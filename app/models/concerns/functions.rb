class Functions
	require 'net/http'
	def initialize(user, site, printer=nil)
		@user = user
		@site = site
		@printer = printer
	end

	def get_request(url, request_params=nil)
		uri = URI.parse(url)
		uri.query = URI.encode_www_form(request_params)
		Net::HTTP.get_response(uri)
	end

	def item_location(api_url, item_number)
    get_request("#{api_url}/transactions/item_location",{item_num: item_number, user: @user})
	end

	def tag_details(api_url, tag_number)
		response = get_request("#{api_url}/transactions/tag_details", {tag: tag_number, user: @user, printer: @printer})
	end

	def print_label(api_url, tag_number, function_type)
		if function_type == "por_print"
			url = "#{api_url}/cardinal_printing/print_label"
		elsif function_type.downcase == "skid_label"
			url = "#{api_url}/cardinal_printing/skid_label"
		else
			url = "#{api_url}/transactions/#{function_type.downcase}"
		end
		params = build_params(function_type, nil, tag_number)
		get_request(url, params)
	end

	def new_tag(api_url)
		get_request("#{api_url}/transactions/plo_next_pallet", {})
	end

	def process_function(api_url, function_type, tag_details, request_params)	
		multiplier = 1
		result = nil
		if function_type == "POR"
			params = build_params(function_type, [request_params[:function]["tag_number"], request_params[:function]["label_count"][0].to_i], request_params)
			p params
			#1.upto(multiplier) do
		 		result = get_request("#{api_url}/transactions/#{function_type.downcase}", params)
		 	#end
		elsif function_type == "CAR"
			request_params[:function]["lines"].zip(request_params[:function]["qtys"], request_params[:function]["prev_packed"], request_params[:function]["multipliers"]).each do |line_data|
			  multiplier =  line_data[3].to_i
			  unless line_data[1].empty?
			  	params = build_params(function_type, tag_details, request_params, line_data)
			  end
			end
			1.upto(multiplier) do
		 		result = get_request("#{api_url}/transactions/#{function_type.downcase}", params)
		 	end
		else
			params = build_params(function_type, tag_details, request_params)
			result = get_request("#{api_url}/transactions/#{function_type.downcase}", params)
	  end
	  
	 	result
  end

  def purchase_order_details(api_url, tag_number)
		get_request("#{api_url}/transactions/po_details", {po_number: tag_number, user: @user})
  end

  def sales_order_details(api_url, request_params)
  	get_request("#{api_url}/transactions/sales_order_details", request_params)
  end

  def skid_create_cartons(api_url, request_params)
  	params = build_params(request_params[:function_type], nil, request_params)
  	get_request("#{api_url}/transactions/skid_create_cartons", params)
  end

  def carton_box_validation(api_url, request_params)
  	get_request("#{api_url}/transactions/carton_box_validation", {box: request_params[:box], user: @user})
  end

  def add_cartons_to_skid(api_url, request_params)
  	get_request("#{api_url}/transactions/skid_create", {skid: request_params[:skid_num], user: @user, site: @site, cartons: request_params[:cartons]})
  end

	def build_params(function, tag_details, request_params, extra_params=nil)
		case function
		when "PCT"
			{to_site: tag_details['result']['ttsite'], qty_to_move: request_params[:function][:move_qty], tag: request_params[:function][:tag_number], user_id: @user}
		when "PDL"
			{item_num: tag_details['result']['ttitem'], qty_to_move: tag_details['result']['ttqtyloc'], from_loc: request_params[:function][:from_location], tag: request_params[:function][:tag_number], to_loc: request_params[:function][:to_location], from_site: @site, to_site: @site, user_id: @user, type: request_params[:function][:function_type]}
		when "PMV"
			{tag: request_params[:function][:tag_number], to_loc: request_params[:function][:to_location], user_id: @user, type: request_params[:function][:function_type]}
		when "PUL"
			{item_num: tag_details['result']['ttitem'], qty_to_move: request_params[:function][:move_qty], from_loc: request_params[:function][:from_location], tag: request_params[:function][:tag_number], to_loc: request_params[:function][:to_location], from_site: @site, to_site: @site, user_id: @user, type: request_params[:function][:function_type]}
		when "TPT"
			{tag: request_params, user: @user, printer: @printer}
		when "GLB"
			{remarks: request_params, user: @user, printer: @printer}
		when "PLO"
			{item_num: request_params[:function][:item_number], from_loc: request_params[:function][:from_loc], from_site: request_params[:function][:from_site], to_site: request_params[:function][:to_site], to_loc: request_params[:function][:to_loc], tag: request_params[:function][:tag_number], qty_to_move: request_params[:function][:move_qty], user_id: @user, type: request_params[:function][:function_type]}
		when "POR"
			lines = Array.new
	    locations = Array.new
	    qtys = Array.new
	    multipliers = Array.new

	    request_params[:function][:lines].zip(request_params[:function][:locations], request_params[:function][:receiving_qtys], request_params[:function][:receiving_multipliers]).each do |param|
				unless param[1].empty? || param[2].empty?
          lines << param[0]
          locations << param[1]
          qtys <<  param[2]
          multipliers << param[3]
        end
       end
       tag_details[1] = tag_details[1] == 0 ? 1 : tag_details[1]
			{dev: @printer, po_num: tag_details[0], "lines[]" => lines, "locations[]" => locations.to_a, "qtys[]" => qtys, "multipliers[]" => multipliers, label_count: tag_details[1], user: @user}
		when "por_print"
			{tag: request_params, printer: @printer, user: @user}
		when "CAR"
			{so: request_params[:function]["so_number"], line: extra_params[0], carton_box: request_params[:function]["carton_tag"], pack_qty: extra_params[1], print: "N", prev_packed: extra_params[2], user: @user, printer:  @printer}
		when "SKD"
  		{so_number: request_params["so_number"], site: @site, user: @user}
  	when "skid_label"
  		{site: @site, skid_num: request_params, printer: @printer, user_id: @user}
		else
		  p function
		end
	end

	def parse_response_body(response)
		JSON.parse response.body
	end
end
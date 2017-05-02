class Functions
	require 'net/http'
	def initialize(user, site, printer=nil)
		@user = user
		@site = site
		@printer = printer
	end

	def item_location(api_url, item_number)
		uri = URI.parse("#{api_url}/transactions/item_location")
    uri.query = URI.encode_www_form({item_num: item_number, user: @user})
    Net::HTTP.get_response(uri)
	end

	def tag_details(api_url, tag_number)
		uri = URI.parse("#{api_url}/transactions/tag_details")
  	uri.query = URI.encode_www_form({tag: tag_number, user: @user, printer: @printer})
		response = Net::HTTP.get_response(uri)
	end

	def print_label(api_url, tag_number, function_type)
		uri = URI.parse("#{api_url}/transactions/#{function_type.downcase}")
		params = build_params(function_type, nil, tag_number)
  	uri.query = URI.encode_www_form(params)
		response = Net::HTTP.get_response(uri)
	end

	def new_tag(api_url)
		uri = URI.parse("#{api_url}/transactions/plo_next_pallet")
		response = Net::HTTP.get_response(uri)
	end

	def process_function(api_url, function_type, tag_details, request_params)
		uri = URI.parse("#{api_url}/transactions/#{function_type.downcase}")
		params = build_params(function_type, tag_details, request_params)
		uri.query = URI.encode_www_form(params)
  	response = Net::HTTP.get_response(uri)
  end

	def build_params(function, tag_details, request_params)
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
			{item_num: request_params[:function][:item_number], from_loc: request_params[:function][:from_loc], from_site: request_params[:function][:from_site], to_site: request_params[:function][:to_site], to_loc: request_params[:function][:to_location], tag: request_params[:function][:tag_number], qty_to_move: request_params[:function][:move_qty], user_id: @user, type: request_params[:function][:function_type]}
		else
		  p function
		end
	end

	def parse_response_body(response)
		JSON.parse response.body
	end
end
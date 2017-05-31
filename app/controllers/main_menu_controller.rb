class MainMenuController < ApplicationController
  
  def index
    @cardinal_functions = {"Inventory" => [["PCT", "Allows ability to change the quantity count on a pallet"], 
                                          ["PDL", "Delete a pallet's inventory."], ["PLO", "Load new product to an existing tag or new tag."], 
                                          ["PMV", "Move pallet from one location to another"], ["PUL", "Unload inventory from a pallet to a new location."]], 
                            "Receiving" => [["POR", "View and receive items by a Purchase Order."]], 
                            "Labels" => [["TPT", "Reprint a tag by number."], ["GLB", "Print a genearl label."], 
                                        ["Skid", "Reprint Label by Skid Number"]], 
                            "Shipping" => [["CAR", "Create a carton from existing items on a Purchase Order"], 
                                          ["CTE", "Delete Carton."], ["SKD", "Create a new skid and add cartons."]]# @cardinal_functions = {"Inventory" => [["PCT (Pallet Cycle Count)", "Allows ability to change the quantity count on a pallet"], 
    #                                       ["PDL (Pallet Delete)", "Delete a pallet's inventory."], ["PLO (Pallet Load)", "Load new product to an existing tag or new tag."], 
    #                                       ["PMV (Pallet Move)", "Move pallet from one location to another"], ["PUL (Pallet Unload)", "Unload inventory from a pallet to a new location."]], 
    #                         "Receiving" => [["POR (Purchase Order Receipt)", "View and receive items by a Purchase Order."]], 
    #                         "Labels" => [["TPT (Tag Reprint)", "Reprint a tag by number."], ["GLB (General Label)", "Print a genearl label."], 
    #                                     ["Skid Label Reprint", "Reprint Label by Skid Number"]], 
    #                         "Shipping" => [["CAR (Carton Create)", "Create a carton from existing items on a Purchase Order"], 
    #                                       ["CTE (Carton Edit)", "Delete Carton."], ["SKD (Skid Create)", "Create a new skid and add cartons."]]
                          }
    @bg_colors = ["#F26101", "#2C3E50", "#6DBCDB", "#FC4349"]
    @bg_counter = 0
    if session[:logged_in].nil?
      flash[:error] = "You are not logged in. Please log in and try again."
      redirect_to login_index_path
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def process_function
    @function_type = params[:function][:function_type]
    @function = Functions.new(session[:username], session[:site], session[:printer])

    if @function_type == "POR"
      @response = @function.process_function(@api_url, @function_type, @response, params)
      @response = @function.parse_response_body(@response)
    elsif @function_type == "CAR"
      @response = @function.process_function(@api_url, @function_type, @response, params)
      @response = @function.parse_response_body(@response)
    else @function_type
      @response = @function.tag_details(@api_url, params[:function][:tag_number])
      @response = @function.parse_response_body(@response)
      @response = @function.process_function(@api_url, @function_type, @response, params)
      @response = @function.parse_response_body(@response)
      @success = @response["success"]
    end
  
  	respond_to do |format|
  		format.js 
		end
  end

  def new_tag
    @function = Functions.new(session[:username], session[:site])
    response = @function.new_tag(@api_url)
    response = @function.parse_response_body(response)
    response[:site] = session[:site]
    respond_to do |format|
      format.json {render json: response}
    end
  end

  def tag_details
    @function = Functions.new(session[:username], session[:site])
    response = @function.tag_details(@api_url, params[:tag_number])

		respond_to do |format|
			format.json {render json: response.body}
		end
  end

  def item_location
    @function = Functions.new(session[:username], session[:site])
    response = @function.item_location(@api_url, params[:item_number])

    respond_to do |format|
      format.json {render json: response.body}
    end
  end

  def purchase_order_details
    @function = Functions.new(session[:username], session[:site])
    response = @function.purchase_order_details(@api_url, params[:tag_number])
    response = @function.parse_response_body(response)
    lines = response["result"]["Lines"]
    locations = response["result"]["Locs"]

    lines.each do |line|
      line["locations"] = Array.new
      locations.each_with_index do |loc, idx|
        if loc["ttpart"] == line["ttitem"]
          line["locations"] << loc["ttlocs"]
          locations.delete_at idx
        end
      end
    end

    response["result"]["Lines"] = lines

    respond_to do |format|
      format.json {render json: response}
    end
  end

  def print_function
    params[:function_type] = params[:function_type] ==  "Skid" ? "skid_label" : params[:function_type]
    @function = Functions.new(session[:username], session[:site], session[:printer])
    response = @function.print_label(@api_url,  params[:tag_number], params[:function_type])
  end

  def carton_function
    @function = Functions.new(session[:username], session[:site], session[:printer])
    response = @function.sales_order_details(@api_url, params)

    respond_to do |format|
      format.json {render json: response.body}
    end
  end

  def skid_create_cartons
    @function = Functions.new(session[:username], session[:site], session[:printer])
    response = @function.skid_create_cartons(@api_url, params)

    respond_to do |format|
      format.json {render json: response.body}
    end
  end

  def carton_box_validation
    @function = Functions.new(session[:username], session[:site], session[:printer])
    response = @function.carton_box_validation(@api_url, params)
    response = @function.parse_response_body(response)

    if response["status"] == "Box Good"
      response = {success: true, result: response["status"]}
    else
      response = {success: false, result: response["error"]}
    end

    respond_to do |format|
      format.json {render json: response}
    end
  end

  def add_cartons_to_skid
    @function = Functions.new(session[:username], session[:site], session[:printer])
    response = @function.add_cartons_to_skid(@api_url, params)
    response = @function.parse_response_body(response)
  end
end

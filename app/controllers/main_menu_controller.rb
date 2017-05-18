class MainMenuController < ApplicationController
  
  def index
    @cardinal_functions = {"Inventory" => ["PCT (Pallet Cycle Count)", "PDL (Pallet Delete)", "PLO (Pallet Load)", "PMV (Pallet Move)", "PUL (Pallet Unload)"], "Receiving" => ["POR (Purchase Order Receipt)"], "Labels" => ["TPT (Tag Reprint)", "GLB (General Label)", "Skid Label Reprint"], "Shipping" => ["CAR (Carton Create)", "CTE (Carton Edit)", "SKD (Skid Create)"]}
    
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

    respond_to do |format|
      format.json {render json: response.body}
    end
  end

  def print_function
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

end

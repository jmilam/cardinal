# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
	$(".card").flip( {
		trigger: 'hover'
	})

$(document).on 'ready', ->

	$('.item_search_btn').on 'click', (e) ->
		e.preventDefaults
		ajaxCardinalFunction '/main_menu/item_lookup', {part: $('.item_search').val()}

	setTimeout ->
		$('.notification').text ''
	, 5000

	$(".card").flip( {
		trigger: 'hover'
	})

	opts = 
		  lines: 13
		  length: 16
		  width: 14
		  radius: 14
		  scale: 0.75
		  corners: 1
		  color: '#000'
		  opacity: 0.2
		  rotate: 0
		  direction: 1
		  speed: 0.8
		  trail: 60
		  fps: 20
		  zIndex: 2e9
		  className: 'spinner'
		  top: '50%'
		  left: '50%'
		  shadow: false
		  hwaccel: false
		  position: 'absolute'

	$('#function_skid_number').on 'keyup', ->
	  if $(this).val().length == 2
	  	$('#function_skid_number').val $('#function_skid_number').val() + '/'
	  else if $(this).val().length == 5
	  	$('#function_skid_number').val $('#function_skid_number').val() + '/'

	$('.submit').on 'click', (e) ->
	  target = document.getElementById('spin')
	  spinner = new Spinner(opts).spin(target)
	  $(target).data('spinner', spinner)

	  $.each $('.bo_check:checked'), (index, value) ->
	    $(this).siblings().first().attr 'disabled', true

	#$('.info-card').on 'click', (e) ->
	  #e.preventDefault()
	  #$(this).parents('.card:first').flip('toggle')
	  #alert 'click'

	$('.card').on 'flip:done', ->
		if $(this).children().css('background-color') == 'rgb(184, 217, 184)'
			$(this).children().css 'background-color', 'white'
		else
			$(this).children().css 'background-color', '#B8D9B8'

	clearCards = ->
		$.each $('.card'), (index, value) ->
			if $(this).children().children().length == 0
				$(this).children().children().css 'background-color', ''
			else
				$(this).children().children().css 'background-color', '#FFFFFF'

	$('.cancel-function').on 'click', (e) ->
		e.preventDefault()
		$('.tag-number').addClass 'hidden'
		$('.function-group').removeClass 'hidden'
		clearCards

	changeDivSize = (from_size, to_size) ->
		$('#function_tag_number').parent().removeClass from_size 
		$('#function_tag_number').parent().addClass to_size
		return

	toggleDivHide = (div_hide, div_show) ->
		div_hide.addClass 'hidden'
		div_show.removeClass 'hidden'
		return

	clearScreen = (div_group) ->
		div_group.children().remove()
		return


	buildPCT = (response) ->
		changeDivSize 'col-md-12', 'col-md-6'
		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttitem + '</div>').appendTo $('.form-fields')
		$('<div class="col-md-6"><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[move_qty]" id="function_move_qty"></div>').appendTo $('.form-fields')
		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttdesc1 + '</div>').appendTo $('.form-fields')
		$('<div class="col-md-6 col-md-offset-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">Current Tag Qty: ' + response.ttqtyloc + '</div>').appendTo $('.form-fields')
		toggleDivHide $('.next-function'), $('.submit')
		return

	buildPDL = (response) ->
		ajaxItemNumber response.ttitem

		changeDivSize 'col-md-12', 'col-md-6'
		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttitem + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_location]" id="function_from_location"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttdesc1 + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_location]" id="function_to_location"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">Current Tag Qty: ' + response.ttqtyloc + '</div>').appendTo $('.form-fields')

		$('#function_from_location').val response.ttloc
		toggleDivHide $('.next-function'), $('.submit')

		return

	buildPMV = (response) ->

		changeDivSize 'col-md-12', 'col-md-6'
		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttitem + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_location]" id="function_from_location"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttdesc1 + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_location]" id="function_to_location"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">Current Tag Qty: ' + response.ttqtyloc + '</div>').appendTo $('.form-fields')

		$('#function_from_location').val response.ttloc
		toggleDivHide $('.next-function'), $('.submit')

		return

	buildPUL = (response) ->
		ajaxItemNumber response.ttitem

		changeDivSize 'col-md-12', 'col-md-6'
		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttitem + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_location]" id="function_from_location"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">' + response.ttdesc1 + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_location]" id="function_to_location"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6 text-center" style="padding-top:15px;height:50px;margin-bottom:10px;">Current Tag Qty: ' + response.ttqtyloc + '</div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="Move Qty" class="form-control custom-text-field" type="text" name="function[move_qty]" id="function_move_qty"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6" style="padding-top:15px;height:50px;margin-bottom:10px;"></div>').appendTo $('.form-fields')

		$('#function_from_location').val response.ttloc
		toggleDivHide $('.next-function'), $('.submit')

		return

	buildPOR = (response) ->
		$('<div class="col-md-12"><input type="text" placeholder="How many tags to print?" name="function[label_count][]" id="function_label_count" class="form-control text-center custom-text-field"></div><div class="col-md-12" style="height:450px;overflow-x: scroll;"><table class= "table table-striped porTable"><thead><tr><th>Item Number</th><th class="text-center">Line Num</th><th class="text-center">Location</th><th class="text-center">Open Qty</th><th class="text-center">Receiving Qty</th><th class="text-center">Multiplier</th></thead><tbody></tbody></table></div>').appendTo $('.form-fields')
		
		$.each response.Lines, (index, value) ->
			$('<tr><td><input value=' + value.ttitem + ' type="hidden" name="function[item][]" id="function_item">' + value.ttitem + '</td><td class="text-center"><input value=' + value.ttline + ' type="hidden" name="function[lines][]" id="function_line">' + value.ttline + '</td><td><select class="form-control custom-text-field loc_select" name="function[locations][]" id="function_location"></td><td class="text-center">' + value.ttqtyopen + '</td><td><input placeholder="Receiving Qty" class="form-control custom-text-field" type="text" name="function[receiving_qtys][]" id="function_receiving_qty"></td><td><input placeholder="Multiplier" class="form-control custom-text-field" type="text" name="function[receiving_multipliers][]" id="function_receiving_multipliers" value="1"></td></tr>').appendTo $('.porTable tbody')

			location_div = $('.loc_select:eq(' + index + ')')
			$.each value.locations, (index, value) ->
				location_div.append '<option value=' + value + '>' + value + '</option>'

		

		$('#function_from_location').val response.ttloc
		toggleDivHide $('.next-function'), $('.submit')

		return

	buildPLO = (response, whole_response) ->
		if $.type(response) == "object"
			if whole_response.success == false
				$('<div class="col-md-6 text-center"><input placeholder="Item Number" class="form-control custom-text-field" type="text" name="function[item_number]" id="function_item_number"></div>').appendTo $('.form-fields')
			else
				$('<div class="col-md-6 text-center"><input placeholder="Item Number" class="form-control custom-text-field" type="text" name="function[item_number]" id="function_item_number" value=' + response.ttitem + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[move_qty]" id="function_move_qty"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Site" class="form-control custom-text-field" type="text" name="function[from_site]" id="function_from_site" value=' + response.ttsite + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Site" class="form-control custom-text-field" type="text" name="function[to_site]" id="function_to_site" value=' + response.ttsite + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_loc]" id="function_from_location"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_loc]" id="function_to_location"  value=' + response.ttloc + '></div>').appendTo $('.form-fields')

		else
			$('#function_tag_number').val response
			$('<div class="col-md-6 text-center"><input placeholder="Item Number" class="form-control custom-text-field" type="text" name="function[item_number]" id="function_item_number"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[move_qty]" id="function_move_qty"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Site" class="form-control custom-text-field" type="text" name="function[from_site]" id="function_from_site" value=' + whole_response.site + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Site" class="form-control custom-text-field" type="text" name="function[to_site]" id="function_to_site" value=' + whole_response.site + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_loc]" id="function_from_location"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_loc]" id="function_to_location"></div>').appendTo $('.form-fields')
			#$('#function_tag_number').val response
			
		$('#function_item_number').focus()
		$('#function_item_number').on 'blur', ->
			ajaxItemNumber $(this).val()

		$('.new_tag').addClass 'hidden'
		changeDivSize 'col-md-6', 'col-md-12'
		toggleDivHide $('.next-function'), $('.submit')

	buildCAR = (response) ->
		$('#function_carton_tag').focus()
		$('<div class="col-md-12" style="height:250px;overflow-x: scroll;"><table class="table table-striped carTable"><thead><tr><th></th><th>Qty to Pack</th><th>Multiplier</th><th class="text-center">Qty Packed</th><th class="text-center">Qty Ordered</th><th class="text-center">Qty Shipped</th><th class="text-center">Carton #</th><th class="text-center">Skid #</th><th class="text-center">Length</th><th class="text-center">Item Desc.</th></tr></thead><tbody></tbody></table></div>').appendTo $('.form-fields')

		$.each response.Lines, (index, value) ->
			$('<tr><td><input value=' + value.ttli + ' class="form-control custom-text-field" type="hidden" name="function[lines][]" id="function_lines"></td><td><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[qtys][]" id="function_qtys"></td><td><input placeholder="Multiplier" class="form-control custom-text-field" type="text" name="function[multipliers][]" id="function_multipliers" value="1"></td><td class="text-center"><input value=' + value.ttqtypck + ' type="hidden" name="function[prev_packed][]" id="function_prev_packed">' + value.ttqtypck + '</td><td class="text-center">' + value.ttqtyord + '</td><td class="text-center">' + value.ttqtyshp + '</td><td class="text-center">' + value.ttcarton + '</td><td class="text-center">' + value.ttskid + '</td><td class="text-center">' + value.ttlength + '</td><td class="text-center">' + value.ttdesc + '</td></tr>').appendTo $('.carTable tbody')
		
		toggleDivHide $('.next-function'), $('.submit')
	
	buildSKD = (response) ->
		$('<div class="col-md-12" style="height:450px;overflow-x: scroll;"><table class= "table table-striped skdTable"><thead><tr><th class="text-center">Line Number</th><th class="text-center">Carton Number</th><th class="text-center">Item</th></thead><tbody></tbody></table></div>').appendTo $('.form-fields')
		
		$.each response, (index, value) ->
			$('<tr><td class="text-center">' + value.ttli + '</td><td class="text-center">' + value.ttcar.match(/[^|]+/g)[0].match(/[^i]+/g)[0] + '</td><td class="text-center">' + value.ttitem + '</td></tr>').appendTo $('.skdTable tbody')

		$('.skdTable tbody tr').on 'click', ->
			if $(this).attr 'selected'
				$(this).css 'background-color', ''
				$(this).removeAttr 'selected'
			else
				$(this).css 'background-color', 'rgba(92, 183, 92, 0.6)'
				$(this).attr 'selected', 'selected'
			

		toggleDivHide $('.next-function'), $('.add-skid')

	buildSHP = (response) ->
		console.log response
		$('<div class="col-md-12" style="height:450px;overflow-x: scroll;"><table class= "table table-striped shpTable"><thead><tr><th class="text-center">Line Number</th><th></th><th class="text-center">Item</th><th></th><th class="text-center">Qty Ordered</th><th class="text-center">Qty Shipped</th><th class="text-center">Open Qty</th><th class="text-center">Cancel B/O</th><th class="text-center">Qty To Ship</th><th class="text-center">Location</th><th class="text-center">Tag/Ref</th></thead><tbody></tbody></table></div>').appendTo $('.form-fields')

		$.each response, (index, value) ->
			$('<tr><td class="text-center">' + value.ttline + '</td><td><input value=' + value.ttline + ' class="form-control custom-text-field" type="hidden" name="function[lines][]" id="function_lines"></td><td class="text-center">' + value.ttitem + '</td><td><input value=' + value.ttitem + ' class="form-control custom-text-field" type="hidden" name="function[items][]" id="function_items"></td><td class="text-center">' + value.ttqtyord + '</td><td class="text-center">' + value.ttqtyshipd + '</td><td class="text-center">' + value.ttqtytoship + '</td><td class="text-center"><input type="hidden" value=false name="function[b_o][]" id="b_o_hidden"><input type="checkbox" name="function[b_o][]" value=false, class="bo_check"></td><td><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[qty_to_ship][]" id="function_qty_to_ship" ></td><td><input placeholder="Location" class="form-control custom-text-field" type="text" name="function[location][]" id="function_location" ></td><td><input placeholder="Tag/Ref" class="form-control custom-text-field" type="text" name="function[tag_ref][]" id="function_tag_ref" ></td></tr>').appendTo $('.shpTable tbody')

		$('.bo_check').on 'change', ->
		  if $(this).is ':checked'
		  	$(this).val true
		  else
		    $(this).val false

		toggleDivHide $('.next-function'), $('.submit')
	
	buildBKF = (response) ->
		$('<div class="col-md-6"><input placeholder="Item Num" class="form-control custom-text-field" type="text" name="function[item_num]" id="function_item_num"></div>').appendTo $('.form-fields')

		$('<div class="col-md-6"><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[qty]" id="function_qty"></div>').appendTo $('.form-fields')

		$('<div class="col-md-12"><select placeholder="Product Line" class="form-control custom-text-field" type="text" name="function[product_line]" id="function_product_line"><option value="" disabled selected>Select Product Line</option></select></div>').appendTo $('.form-fields')

		toggleDivHide $('.next-function'), $('.submit')

		$('#function_item_num').focus()

		$('#function_item_num').on 'blur', (e) ->
			ajaxCardinalFunction '/main_menu/get_product_lines', {item_num: $('#function_item_num').val()}

	printTag = (tag_num) ->
		alert tag_num

	parseJSONResponse = (json) ->
		JSON.parse JSON.stringify json

	$('.printYes').on 'click', ->
	  $('#myModal').modal 'hide'
	  ajaxCardinalFunction '/main_menu/print_function', {tag_number: $('#printTagNum').text(), function_type: 'por_print'}
	  $('#printTagNum').text ''

	$('.printNo').on 'click', ->
	  $('#myModal').modal 'hide'
	  $('#printTagNum').text ''

	$(".card").on 'click', ->
		function_type = $(this).children().children('.front').text().trim().match(/[^()]+/g)[0].trim()
		bg_color = $(this).siblings('div:eq(0)').css('background-color')
		$('.panel-heading').css 'background-color', bg_color
		$('.function-header').text function_type
		$('.function_type').val function_type

		$('.tag-number').removeClass 'hidden'
		$('.function-group').addClass 'hidden'

		toggleDivHide $('.submit'), $('.next-function')
		$('.submit').prop 'disabled', false

		clearScreen $('.form-fields')
		$('#function_tag_number').val ''
		
		if function_type == "PLO"
			changeDivSize 'col-md-12', 'col-md-6'
			$('.new_tag').removeClass 'hidden'
			$('.add-skid').addClass 'hidden'
		else if function_type == "POR"
			changeDivSize 'col-md-6', 'col-md-12'
			$('#function_tag_number').attr 'placeholder', "Enter Purchase Order Number"
			$('#function_tag_number').removeClass 'hidden'
			$('.tag_number').removeClass 'hidden'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.carton_tag').addClass 'hidden'	
			$('.sales_order').addClass 'hidden'
			$('.skid_number').addClass 'hidden'
			$('.add-skid').addClass 'hidden'
		else if function_type == "CAR"
			changeDivSize 'col-md-12', 'col-md-6'
			$('.tag_number').addClass 'hidden'
			$('.sales_order').removeClass 'hidden'
			$('.line_number').removeClass 'hidden'
			$('.carton_tag').removeClass 'hidden'
			$('.skid_number').addClass 'hidden'
			$('.add-skid').addClass 'hidden'
		else if function_type == "CTE"
			$('#function_tag_number').addClass 'hidden'
			$('.carton_tag').removeClass 'hidden'
			$('.carton_tag').attr 'placeholder', 'Enter Carton #'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.sales_order').addClass 'hidden'
			$('.skid_number').addClass 'hidden'
			$('.add-skid').addClass 'hidden'
			toggleDivHide $('.next-function'), $('.submit')
		else if function_type == "SKD"
			$('.sales_order').removeClass 'hidden'
			$('.sales_order').children().val ''
			$('.skid_number').removeClass 'hidden'
			$('.skid_number').children().val ''
			$('#function_tag_number').addClass 'hidden'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.carton_tag').addClass 'hidden'	
			$('.add-skid').addClass 'hidden'
			$('#function_skid_number').attr 'placeholder', 'Skid Number'
		else if function_type == "SHP"
			$('.sales_order').removeClass 'hidden'
			$('.sales_order').children().val ''
			$('.skid_number').removeClass 'hidden'
			$('.skid_number').children().val ''
			$('#function_tag_number').addClass 'hidden'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.carton_tag').addClass 'hidden'	
			$('.add-skid').addClass 'hidden'
			$('#function_skid_number').attr 'placeholder', 'Effective Date (Default Date: Today)'
		else if function_type == "BKF"
			$('.sales_order').addClass 'hidden'
			$('.skid_number').addClass 'hidden'
			$('#function_tag_number').addClass 'hidden'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.carton_tag').addClass 'hidden'	
			$('.add-skid').addClass 'hidden'
			buildBKF 'hello'
		else
			changeDivSize 'col-md-6', 'col-md-12'
			$('#function_tag_number').removeClass 'hidden'
			$('.tag_number').removeClass 'hidden'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.carton_tag').addClass 'hidden'	
			$('.sales_order').addClass 'hidden'
			$('.skid_number').addClass 'hidden'
			$('.add-skid').addClass 'hidden'

			if $(".function-header").text() == "Skid"
				$('#function_tag_number').attr 'placeholder', "Enter Existing Skid Number for reprint"
			else if $(".function-header").text() == "GLB"
				$('#function_tag_number').attr 'placeholder', 'Enter General Label Text (limit: 15 characters)'
			else
				$('#function_tag_number').attr 'placeholder', "Enter Existing Tag Number"

	$('.next-function').on 'click', ->
		switch $('.function-header').text().match(/[^()]+/g)[0].trim()
			when "TPT" then ajaxCardinalFunction '/main_menu/print_function', {tag_number: $('#function_tag_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			when "GLB" then ajaxCardinalFunction '/main_menu/print_function', {tag_number: $('#function_tag_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			when "POR" then ajaxCardinalFunction '/main_menu/purchase_order_details', {tag_number: $('#function_tag_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			when "CAR" then ajaxCardinalFunction '/main_menu/carton_function', {so_number: $('#function_so_number').val(), line_number: $('#function_line_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			when "SKD" then ajaxCardinalFunction '/main_menu/skid_create_cartons', {so_number: $('#function_so_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			when "Skid" then ajaxCardinalFunction '/main_menu/print_function', {tag_number: $('#function_tag_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			when "SHP" then ajaxCardinalFunction '/main_menu/ship_lines', {so_number: $('#function_so_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
			else
				$('#printTagNum').text $('#function_tag_number').val()
				ajaxCardinalFunction '/main_menu/tag_details', {tag_number: $('#function_tag_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}
		$('.submit').attr 'disabled', false

	$('.new_tag').on 'click', ->
		ajaxCardinalFunction '/main_menu/new_tag', {tag_number: $('#function_tag_number').val(), function_type: $('.function-header').text().match(/[^()]+/g)[0].trim()}

	$('.add-skid').on 'click', ->
		cartons = []

		$.each $('.skdTable tbody tr[selected=selected]'), (index,row) ->
			cartons[index] = $(this).children('td:eq(1)').text()

		cartons = cartons.toString()
		ajaxCardinalFunction '/main_menu/add_cartons_to_skid', {skid_num: $('#function_skid_number').val(), cartons: cartons}

	$('#function_carton_tag').on 'blur', ->
		if $(this).val() == ""
			$('#function_carton_tag').css('border', '1px solid red')
			$(this).focus()
		else
			ajaxCardinalFunction '/main_menu/carton_box_validation', {box: $('#function_carton_tag').val()}
			$('#function_carton_tag').css('border', '1px solid rgb(204,204,204)')

	buildData = (selectedAction, response, whole_response) -> 
		switch selectedAction

			when "PCT" then buildPCT response
			when "PDL" then buildPDL response
			when "PMV" then buildPMV response
			when "PUL" then buildPUL response
			when "PLO" then buildPLO response, parseJSONResponse whole_response
			when "plo_item_number" then alert 'fill it in'
			when "POR" then buildPOR response if response.Status == true
			when "CAR" then buildCAR response if response.status == "Good"
			when "CTE" then alert 'CTE'
			when "SKD" then buildSKD response if $.type(response) == "array"
			when "SHP" then buildSHP response
			else   

	addDataToSelect = (values) ->
	  $.each values.split(','), (index, value) -> 
	  	$('#function_product_line').append $('<option value=' + value + '>' + value + '</option>')

	ajaxItemNumber = (item_number) ->
			$.ajax
				url: '/main_menu/item_location'
				type: 'GET'
				dataType: 'json'
				data: item_number: item_number
				success: (response) ->
					if response.success == "Good"
						response = parseJSONResponse response.Location
						if $('.function-header').text() == "PLO"
							$('#function_from_location').val response
						else
							$('#function_to_location').val response
					else
						response = parseJSONResponse response.success

	ajaxCardinalFunction = (url, params) ->
			$.ajax
				url: url
				type: 'GET'
				dataType: 'json'
				data: params
				success: (response) ->
					whole_response = response
					if response.success == true
						if response.result == undefined
						else
							response = parseJSONResponse response.result
						
						if url.trim() == '/main_menu/tag_details'
						else
							$('.notification').text 'Successful ' + $(".function-header").text() + ' Transaction!'
							setTimeout ->
								$('.notification').text ''
							, 5000

						buildData params['function_type'], response, whole_response
					else if response.success == "Good" || response.success == "good"
						if $(".function-header").text() == "BKF"
							addDataToSelect response.ProdLines
						else
							$('#itemModal').children().children().children('.modal-header').children('p').remove()
							$('#itemModal').children().children().children('.modal-body').children('table').children('tbody').children('tr').remove()
							$('#itemModal').children().children().children('.modal-header').append '<p class="text-center">' + $('#item_search').val() + '</p>'

							$.each response.INFO, (index, value) ->
								$('#itemModal').children().children().children('.modal-body').children('table').children('tbody').append '<tr><td>' + value.ttdesc1 + '</td><td>' + value.ttloc + '</td><td>' + value.ttqtyloc + '</td></tr>'

							$('#itemModal').modal 'show'
					else if response.status == "Good"
						$('.notification').text 'Successful ' + $(".function-header").text() + ' Transaction!'
						buildData params['function_type'], response, whole_response
					else
						$('.notification').text 'Error ' + $(".function-header").text() + ' Transaction!'
						response = parseJSONResponse response.result
						buildData params['function_type'], response, whole_response

		


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready', ->
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

	  $('#function_from_location').val response.ttloc
	  toggleDivHide $('.next-function'), $('.submit')

	  return

	buildPOR = (response) ->
	  console.log response
	  $('<div class="col-md-12"><input type="text" placeholder="How many tags to print?" name="function[label_count][]" id="function_label_count" class="form-control text-center"></div><div class="col-md-12" style="height:450px;overflow-x: scroll;"><table class= "table table-striped porTable"><thead><tr><th>Item Number</th><th class="text-center">Line Num</th><th class="text-center">Location</th><th class="text-center">Open Qty</th><th class="text-center">Receiving Qty</th></thead><tbody></tbody></table></div>').appendTo $('.form-fields')
	  
	  $.each response.Lines, (index, value) ->
	  	$('<tr><td><input value=' + value.ttitem + ' type="hidden" name="function[item][]" id="function_item">' + value.ttitem + '</td><td class="text-center"><input value=' + value.ttline + ' type="hidden" name="function[lines][]" id="function_line">' + value.ttline + '</td><td><input placeholder="Location" class="form-control custom-text-field" type="text" name="function[locations][]" id="function_location"></td><td class="text-center">' + value.ttqtyopen + '</td><td><input placeholder=" Receiving Qty" class="form-control custom-text-field" type="text" name="function[receiving_qtys][]" id="function_receiving_qty"></td></tr>').appendTo $('.porTable tbody')
	  

	  $('#function_from_location').val response.ttloc
	  toggleDivHide $('.next-function'), $('.submit')

	  return

	buildPLO = (response, whole_response) ->
		if $.type(response) == "object"
			$('<div class="col-md-6 text-center"><input placeholder="Item Number" class="form-control custom-text-field" type="text" name="function[item_number]" id="function_item_number" value=' + response.ttitem + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[move_qty]" id="function_move_qty"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Site" class="form-control custom-text-field" type="text" name="function[from_site]" id="function_from_site" value=' + response.ttsite + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Site" class="form-control custom-text-field" type="text" name="function[to_site]" id="function_to_site" value=' + response.ttsite + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_loc]" id="function_from_location" value=' + response.ttloc + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_loc]" id="function_to_location"></div>').appendTo $('.form-fields')
			$('#function_tag_number').val response.tttag
		else
			$('<div class="col-md-6 text-center"><input placeholder="Item Number" class="form-control custom-text-field" type="text" name="function[item_number]" id="function_item_number"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="Qty" class="form-control custom-text-field" type="text" name="function[move_qty]" id="function_move_qty"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Site" class="form-control custom-text-field" type="text" name="function[from_site]" id="function_from_site" value=' + whole_response.site + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Site" class="form-control custom-text-field" type="text" name="function[to_site]" id="function_to_site" value=' + whole_response.site + '></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="From Location" class="form-control custom-text-field" type="text" name="function[from_loc]" id="function_from_location"></div>').appendTo $('.form-fields')
			$('<div class="col-md-6"><input placeholder="To Location" class="form-control custom-text-field" type="text" name="function[to_loc]" id="function_to_location"></div>').appendTo $('.form-fields')
			$('#function_tag_number').val response
			
		$('#function_item_number').focus()
		$('#function_item_number').on 'blur', ->
			ajaxItemNumber $(this).val()

		$('.new_tag').addClass 'hidden'
		changeDivSize 'col-md-6', 'col-md-12'
		toggleDivHide $('.next-function'), $('.submit')

		
	printTag = (tag_num) ->
	  alert tag_num

	parseJSONResponse = (json) ->
		JSON.parse JSON.stringify json

					
	$('.function-table td').on 'click', ->
		toggleDivHide $('.submit'), $('.next-function')
		$('.submit').prop 'disabled', false

		clearScreen $('.form-fields')
		
		$('#function_tag_number').val ''
		$('.function_type').val $(this).text().match(/[^()]+/g)[0].trim()
		$('.function-header').text $(this).text()

		$(this).parent().siblings().css 'background-color', ''
		$(this).parent().css 'background-color', 'tan'
		$('.tag-number').removeClass 'hidden'

		if $(this).text().match(/[^()]+/g)[0].trim() == "PLO"
			changeDivSize 'col-md-12', 'col-md-6'
			$('.new_tag').removeClass 'hidden'
		else if $(this).text().match(/[^()]+/g)[0].trim() == "POR"
			$('#function_tag_number').attr 'placeholder', "Enter Purchase Order Number"
		else if $(this).text().match(/[^()]+/g)[0].trim() == "CAR"
			changeDivSize 'col-md-12', 'col-md-6'
			$('.line_number').removeClass 'hidden'
			$('.carton_tag').removeClass 'hidden'
		else
			changeDivSize 'col-md-6', 'col-md-12'
			$('.new_tag').addClass 'hidden'
			$('.line_number').addClass 'hidden'
			$('.carton_tag').addClass 'hidden'

		

	$('.next-function').on 'click', ->
		switch $('.function-header').text().match(/[^()]+/g)[0].trim()
		  when "TPT" then ajaxCardinalFunction '/main_menu/print_function', $('#function_tag_number').val(), $('.function-header').text().match(/[^()]+/g)[0].trim()
		  when "GLB" then ajaxCardinalFunction '/main_menu/print_function', $('#function_tag_number').val(), $('.function-header').text().match(/[^()]+/g)[0].trim()
		  when "POR" then ajaxCardinalFunction '/main_menu/purchase_order_details', $('#function_tag_number').val(), $('.function-header').text().match(/[^()]+/g)[0].trim()
		  else
			ajaxCardinalFunction '/main_menu/tag_details', $('#function_tag_number').val(), $('.function-header').text().match(/[^()]+/g)[0].trim()
		$('.submit').attr 'disabled', false

	$('.new_tag').on 'click', ->
		ajaxCardinalFunction '/main_menu/new_tag', $('#function_tag_number').val(), $('.function-header').text().match(/[^()]+/g)[0].trim()


	ajaxItemNumber = (item_number) ->
    	$.ajax
	      url: '/main_menu/item_location'
	      type: 'GET'
	      dataType: 'json'
	      data: item_number: item_number
	      success: (response) ->
	      	if response.success == "Good"
	      		response = parseJSONResponse response.Location
	      		$('#function_to_location').val response
	      	else
        		response = parseJSONResponse response.success

	ajaxCardinalFunction = (url, tag_number, selectedAction) ->
	  	$.ajax
	      url: url
	      type: 'GET'
	      dataType: 'json'
	      data: tag_number: tag_number, function_type: selectedAction
	      success: (response) ->
	      	if response.success == true
	      		whole_response = response
	      		response = parseJSONResponse response.result

	      		switch selectedAction
	      		  when "PCT" then buildPCT response
	      		  when "PDL" then buildPDL response
	      		  when "PMV" then buildPMV response
	      		  when "PUL" then buildPUL response
	      		  when "PLO" then buildPLO response, parseJSONResponse whole_response
	      		  when "plo_item_number" then alert 'fill it in'
	      		  when "POR" then buildPOR response
	      		  when "CAR" then alert 'CAR'
	      		  when "CTE" then alert 'CTE'
	      		  when "SKD" then alert 'SKD'
	      		  else     		
	      	else
        		response = parseJSONResponse response.result

		


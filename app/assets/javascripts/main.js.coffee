# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready( () ->
	$('.done_task').each( (i, obj) ->
		if $(obj).hasClass("checked")
			$(obj).prop('checked', true)
	)
)
	
$(document).on('click','.edit_project', ()->
	project_id = $(this).attr('class').match(/\d+/)
	span = $('.project_name.' + project_id + ' span')
	input = $('.project_name.' + project_id + ' input')
	span.addClass("hidden")
	input.removeClass("hidden")
	$('.project_name input').not(input).addClass("hidden")
	$('.project_name span').not(span).removeClass("hidden")
	input.focus()
)

$(document).on('click','.edit_task', ()->
	task_id = $(this).attr('id').match(/\d+/)
	span = $('.task_fields_' + task_id)
	span.slideToggle( "fast", () ->
		span.toggleClass('hidden')
	)
)

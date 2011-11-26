$ ->
  load_images()
  $('#image_url').val($('#image_list li.current img').attr('src'))
  configure_buttons()
  $('#item_url').change ->
    load_images()

configure_buttons = ->
  $('#previous_image').click (e) ->
    e.preventDefault()
    $('#image_list li.current').removeClass('current').prev().addClass('current')
    if $('#image_list li.current').length == 0
      $('#image_list li:last-child').addClass('current')
    $('#image_url').val($('#image_list li.current img').attr('src'))

  $('#next_image').click (e) ->
    e.preventDefault()
    $('#image_list li.current').removeClass('current').next().addClass('current')
    if $('#image_list li.current').length == 0
      $('#image_list li:first-child').addClass('current')
    $('#image_url').val($('#image_list li.current img').attr('src'))

load_images = ->
  if /https?:\/\/.+\..+/i.test $('#item_url').val()
    $("#previous_image").removeClass('disabled')
    $('#next_image').removeClass('disabled')
    $('#item_url').parents('form').find('input.btn.primary').removeAttr('disabled')
    data =
      url: $('#item_url').val()
    success = (data, textStatus, jqXHR) ->
      append_image(src, '#image_list') for src in data
      $('#image_list li:first-child').addClass('current')
    $.getJSON("/items/url_images.json", data, success)
  else
    $("#previous_image").addClass('disabled')
    $('#next_image').addClass('disabled')
    $('#item_url').parents('form').find('input.btn.primary').attr('disabled', 'disabled')

append_image = (src, parent) ->
  li = $('<li />')
  $('<img />', src: src).appendTo(li)
  li.appendTo(parent)

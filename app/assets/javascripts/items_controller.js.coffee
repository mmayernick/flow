$ ->
  $('#item_url').change ->
    if /https?:\/\/.+\..+/i.test $('#item_url').val()
      $('#item_url').parents('form').find('input.btn.primary').removeAttr('disabled')
      data = 
        url: $('#item_url').val()
      success = (data, textStatus, jqXHR) ->
        console.log 'woot'
        console.log data
      $.getJSON("/items/url_images.json", data, success)
    else
      $('#item_url').parents('form').find('input.btn.primary').attr('disabled', 'disabled')
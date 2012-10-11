$ ->
  $('#persona-button').click (event) ->
    navigator.id.request { siteName: 'ascii.io' }
    event.preventDefault()

  navigator.id.watch
    onlogin: (assertion) ->
      console.log 'onlogin'

      if assertion
        $('input[name=assertion]').val assertion
        $('#browser_id_form').submit()

    onlogout: ->
      console.log 'onlogout'
      window.location = '/logout'

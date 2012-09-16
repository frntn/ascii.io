function loginViaPersona() {
  navigator.id.get(function(assertion) {
    if (assertion) {
      $('input[name=assertion]').val(assertion);
      $('#browser_id_form').submit();
    } else {
      window.location = "#{failure_path}"
    }
  });
}

$(function() {
  $('#persona-button').click(function() {
    loginViaPersona();
    return false;
  });
});

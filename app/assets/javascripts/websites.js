var ready = function () {
  $('#url_field').keyup(function() {
    var url = $(this).val()
    if (IsvalidURL(url)) {
      $(this).parent().attr("class",'form-group has-feedback has-success');
    } else {
      $(this).parent().attr("class",'form-group has-feedback has-error');
    }
  });

  $("#form_url").submit(function(e){
    url = $('#url_field').text();
    if (IsvalidURL(url)) {
      console.log($(this).val());
      e.submit();
    } else {
      e.preventDefault();
    }
  });

  function IsvalidURL(textval) {
    var urlregex = /^(https?|ftp):\/\/([a-zA-Z0-9.-]+(:[a-zA-Z0-9.&%$-]+)*@)*((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}|([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(:[0-9]+)*(\/($|[a-zA-Z0-9.,?'\\+&%$#=~_-]+))*$/;
    return urlregex.test(textval);
  }
}

$(document).ready(ready);
$(document).on("turbolinks:load", ready);

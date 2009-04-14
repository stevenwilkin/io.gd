/**
 * io.gd
 * Steven Wilkin - http://stevenwilkin.com
 */

$(document).ready(function(){
  // auto-focus url input field
  $('#url_url').focus();
  // select contents of shortened url field when clicked
  $('#short_url').click(function(){
    $(this).select(); 
  });
});

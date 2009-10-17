$(function() {
  
  $(".admin-actions").each(function(){
    var current = $(this);
    var parent  = current.parent();
    parent.mouseover(function() {
      current.show();
    });
    parent.mouseout(function() {
      current.hide();
    });
  }).hide();
  
});

$(document).on('click', '.btn-add', function(e)
{
  e.preventDefault();

  var currentEntry = $(this).parents('.param_row:last'),
      newEntry = $(currentEntry.clone()).appendTo('.param_container:last');

  newEntry.find('input').val('');
  newEntry.find('.btn-add')
      .removeClass('btn-default').addClass('btn-danger')
      .removeClass('btn-add').addClass('btn-remove')
      .html('<span aria-hidden="true"></span> Remove   ');
  $('#fan_collector').validator('update');

}).on('click', '.btn-remove', function(e)
{
  $(this).parents('.param_row:last').remove();

  e.preventDefault();
  $('#fan_collector').validator('update');
  return false;
});


$(function () {
  $('[data-toggle="tooltip"]').tooltip();

  $(document).on('click', '.btn-add', function (e) {
    e.preventDefault();

    var currentEntry = $(this).parents('.param_row:first'),
        newEntry = $(currentEntry.clone()).appendTo('.param_container');

    currentEntry.find('.btn-add')
        .hide();
    currentEntry.find('.btn-remove')
        .hide();

    newEntry.find('input').val('');
    newEntry.find('.btn-remove')
        .show();

    $('#fan_collector').validator('update');
    $('[data-toggle="tooltip"]').tooltip();

  }).on('click', '.btn-remove', function (e) {
    var newLastRow$ = $(this).parents('.param_row:last').prev();
    $(this).parents('.param_row:last').remove();
    newLastRow$.find('.btn-add').show();
    if ($('.param_row').length != 1) {
      newLastRow$.find('.btn-remove').show();
    }
    e.preventDefault();
    $('#fan_collector').validator('update');
    return false;
  });
});

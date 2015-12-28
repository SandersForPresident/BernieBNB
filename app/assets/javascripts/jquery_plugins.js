$(document).ready(function () {
  $("#visit_start_date").datepicker({
    dateFormat: "dd-M-yy",
    minDate: 0,
    onSelect: function () {
      var endDate = $('#visit_end_date');
      var startDate = $(this).datepicker('getDate');
      var minDate = $(this).datepicker('getDate');
      startDate.setDate(startDate.getDate() + 30);

      endDate.datepicker('setDate', minDate);
      endDate.datepicker('option', 'maxDate', startDate);
      endDate.datepicker('option', 'minDate', minDate);
      $(this).datepicker('option', 'minDate', minDate);
    }
  });

  $('#visit_end_date').datepicker({
    dateFormat: "dd-M-yy"
  });

  $('#accordion').accordion({
    active: false,
    collapsible: true
  });
});

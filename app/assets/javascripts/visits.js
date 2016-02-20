App.Visits = {};

App.Visits.init = function() {
  this.sDate = $('#visit_start_date');
  this.eDate = $('#visit_end_date');

  this.initDatepicker();

  $('.new_visit, .edit_visit').submit(function(event) {
    if(App.Visits.sDate.val() && App.Visits.eDate.val() === '') {
      App.Visits.eDate.val(App.Visits.sDate.val());
    }
  });
};

App.Visits.initDatepicker = function() {
  var start = this.sDate;
  var end = this.eDate;

  var dp = $('.datepicker').datepicker({
    dateFormat: 'yy-mm-dd',
    dayNamesMin: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    minDate: 0,
    // showWeek: true,
    weekHeader: '',
    beforeShowDay: function(dateText) {
      var arrive = moment(start.val());
      var date = moment(dateText);

      var highlight = date.isSame(arrive) || (date.isBetween(arrive, moment(end.val()).add(1, 'd')));
      return [true, highlight ? 'highlight' : ''];
    },
    onSelect: function(dateText) {
      var startDate = moment(start.val());
      var endDate = moment(end.val());
      var date = moment(dateText);
      var dateFormat = 'YYYY-MM-DD';

      if(!startDate.isValid() || endDate.isValid()) {
        start.val(date.format(dateFormat));
        end.val('');
      }
      else if(date.isSame(startDate)) {
        start.val('');
        end.val('');
      }
      else if(date.isBefore(startDate)) {
        end.val(startDate.format(dateFormat));
        start.val(date.format(dateFormat));
      }
      else {
        end.val(date.format(dateFormat));
      }
    }
  });

  if(start) {
    dp.datepicker('setDate', start.val());
  }
};

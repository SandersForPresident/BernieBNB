desc 'clear past dated visits'

task clear_past_dated_visits: :environment do
  print 'clearing past-dated visits...'

  old_visits = Visit.where('start_date <= ?', 1.day.ago).destroy_all

  puts " #{old_visits.count} records deleted"
end

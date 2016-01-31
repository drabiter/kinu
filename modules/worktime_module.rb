require "business_time"

module WorktimeModule
  BusinessTime::Config.beginning_of_workday = "9:00 am"
  BusinessTime::Config.end_of_workday       = "6:00 pm"

  def self.trim_to_worktime(start_date, end_date)
    work_hours = start_date.business_time_until(end_date) / (60 * 60)
    rest_hours = (work_hours / 9).floor
    work_hours - rest_hours
  end

end

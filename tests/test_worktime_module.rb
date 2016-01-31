require "minitest/autorun"
require "business_time"

require_relative "../modules/worktime_module"

class TestWorktime < Minitest::Test

  def setup
    BusinessTime::Config.beginning_of_workday = "9:00 am"
    BusinessTime::Config.end_of_workday       = "6:00 pm"
  end

  def test_trim_to_worktime
    start_date = Time.gm 2016, 2, 1, 9
    end_date   = Time.gm 2016, 2, 8, 9
    assert_equal 40, WorktimeModule.trim_to_worktime(start_date, end_date)

    start_date = Time.gm 2016, 2, 2, 9
    end_date   = Time.gm 2016, 2, 4, 9
    assert_equal 16, WorktimeModule.trim_to_worktime(start_date, end_date)

    start_date = Time.gm 2016, 2, 1, 9
    end_date   = Time.gm 2016, 2, 16, 9
    assert_equal 88, WorktimeModule.trim_to_worktime(start_date, end_date)

    start_date = Time.gm 2016, 2, 1, 9
    end_date   = Time.gm 2016, 2, 7, 9
    assert_equal 40, WorktimeModule.trim_to_worktime(start_date, end_date)
  end

end

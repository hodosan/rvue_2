module CalendarData
  extend ActiveSupport::Concern

  def calendar_for_view(month)
      # enable：models/calender.rbで定義
      @enable_days = Calendar.enable
      if month == "next"
      @today       = Date.today.next_month
      else
      @today       = Date.today
      end
      @this_month  = @today.strftime("%m")
      # @weeks導出準備
      month_1st    = @today.beginning_of_month
      month_last   = @today.end_of_month
      month_1st_wd = @today.beginning_of_month.wday
      cal_first    = month_1st - month_1st_wd
      cal_end      = cal_first + 6
      @weeks = []
      6.times do |i|
      week_range = Range.new(cal_first + 7*i, cal_end + 7*i )
      @weeks << week_range
      break if week_range.include?(month_last)
      end
      @day_enable = make_array_enable_days(@today, @weeks, @enable_days)
  end

  def make_array_enable_days(today, weeks, enable_days)
    enables = enable_days.map do |ed|
      ed.day
    end 
    
    day_enable = {}
    weeks.each do |wk|
      wk.each do |day|
        val = enables.include?(day) ? :enable : :closed
        day_enable[day] = val
      end
    end
    
    return day_enable
  end

  def minute_blocks(selected_day_data)
    day         = selected_day_data.day
    begin_time  = selected_day_data.begin_time
    close_time  = selected_day_data.close_time
    interval_s  = selected_day_data.interval_s
    interval_e  = selected_day_data.interval_e
    unit_minute = selected_day_data.unit_minute

    mns = []
    tm = begin_time
    while tm < close_time
        if tm >= interval_s && tm < interval_e
        else
            mns << tm.strftime("%H:%M")
        end
        tm = tm + unit_minute*60
    end
    return day, mns
  end

end
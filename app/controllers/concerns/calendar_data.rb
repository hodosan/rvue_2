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
      # 後述　---> c-2
      month_1st    = @today.beginning_of_month
      month_last   = @today.end_of_month
      month_1st_wd = @today.beginning_of_month.wday
      cal_first    = month_1st - month_1st_wd
      cal_end      = cal_first + 6
      # @week作成：Ruby範囲(Range)オブジェクト
      # 後述　---> c-1
      @weeks = []
      6.times do |i|
      week_range = Range.new(cal_first + 7*i, cal_end + 7*i )
      @weeks << week_range
      break if week_range.include?(month_last)
      end
      # 予約可否ハッシュ作成（helper method : make_array_enable_days）使用
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
end
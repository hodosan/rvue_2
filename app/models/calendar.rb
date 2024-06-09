class Calendar < ApplicationRecord
  scope :enable, ->{ where("day >= ?", Date.today) }

  validates :day,
    presence: true,
    uniqueness: true
  # time_changed?が発生したときにtime_validを実行します
  validate :time_valid,              if: :time_changed?
  # interval_changed?が発生したときにinterval_valiを実行します
  validate :interval_valid,          if: :interval_changed?

  def time_changed?
    # 項目begin_timeまたはclose_timeが変化したときtrueを返す
    self.begin_time_changed? || self.close_time_changed?
  end

  def interval_changed?
    # 項目interval_sまたはinterval_eが変化したときtrueを返す
    self.interval_s_changed? || self.interval_e_changed?
  end

  def time_valid
    # close_timeがbegin_timeより小さいときエラーに
    if self.close_time < self.begin_time
      errors.add(:close_time, "の時刻は、#{self.begin_time.strftime('%H:%M')}より前の時刻にして下さい。")
      return
    end
  end

  def interval_valid
    # interval_eがinterval_sより小さいときエラーに
    if self.interval_e < self.interval_s
      errors.add(:interval_e, "の時刻は、#{self.interval_s.strftime('%H:%M')}より前の時刻にして下さい。")
      return
    end
    # interval_eがclose_timeより大きいエラーに
    if self.interval_e > self.close_time
      errors.add(:interval_e, "の時刻は、#{self.close_time.strftime('%H:%M')}より前の時刻にして下さい。")
      return
    end
    # interval_sがbegin_timeより小さいときエラーに
    if self.interval_s < self.begin_time
      errors.add(:interval_s, "の時刻は、#{self.begin_time.strftime('%H:%M')}より後の時刻にして下さい。")
      return
    end

  end
end
module TimeConversion
  def self.hours_to_seconds(hr)
      # should really be hr * 60 * 60 for hours
      # right now i'm converting minutes to seconds
      hr * 60
  end

  def self.seconds_to_hours(sec)
    (sec / 60) / 60
  end

  def self.dt_diff(time_1, time_2, format)
      # sec = "s", min = "m", hours = "h", days = "d"
      diff = time_1 - time_2
      (diff / 60) / 60 if format == 'h'
      (diff / 60) if format == 'm'
      diff if format == 's'
  end
end

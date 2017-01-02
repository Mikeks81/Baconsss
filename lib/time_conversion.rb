module TimeConversion
  def self.hours_to_seconds(hr)
      # should reall be hr * 60 * 60 for hours
      # right now i'm converting minutes to seconds
      hr * 60
  end

  def self.dt_diff(time_1, time_2, format)
      # sec = "s", min = "m", hours = "h", days = "d"
      diff = time_1.to_f - time_2.to_f
      (diff / 60) / 60 if format == 'h'
  end
end

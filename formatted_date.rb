require "./year"
require "./month"
require "./day"

class FormattedDate
  def initialize(date_type)
    @date_type = date_type
    @year = Year.new(date_type).value
    @month = Month.new(date_type).value
    @day = Day.new(date_type).value
  end

  def format
    if valid_date?
      (@year.to_s.rjust(4, "0") + @month.to_s.rjust(2, "0") + @day.to_s.rjust(2, "0")).to_i
    else
      puts "不正な日付です"
      request_new_date
      format
    end
  end

  private

  def valid_date?
    Time.new(@year, @month, @day).strftime("%F") == @year.to_s.rjust(4, "0") + "-" + @month.to_s.rjust(2, "0") + "-" + @day.to_s.rjust(2, "0")
  end

  def request_new_date
    @year = Year.new(@date_type).value
    @month = Month.new(@date_type).value
    @day = Day.new(@date_type).value
  end
end
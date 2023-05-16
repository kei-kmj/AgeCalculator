# frozen_string_literal: true

require './lib/year_receiver'
require './lib/month_receiver'
require './lib/day_receiver'

class DateSanitizer
  def initialize(date_type)
    @date_type = date_type
    renew
  end

  def ensure_valid
    if valid?
      formatted
    else
      puts '不正な日付です'
      renew
      ensure_valid
    end
  end

  private

  def formatted
    "#{@year.to_s.rjust(4, '0')}#{@month.to_s.rjust(2, '0')}#{@day.to_s.rjust(2, '0')}".to_i
  end

  def valid?
    Time.new(@year, @month, @day).strftime('%F') == \
      "#{@year.to_s.rjust(4, '0')}-#{@month.to_s.rjust(2, '0')}-#{@day.to_s.rjust(2, '0')}"
  end

  def renew
    @year = YearReceiver.new(@date_type).value
    @month = MonthReceiver.new(@date_type).value
    @day = DayReceiver.new(@date_type).value
  end
end

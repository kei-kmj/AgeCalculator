# frozen_string_literal: true

require './lib/date_sanitizer'

class AgeIndicator
  def initialize
    @birthday = DateSanitizer.new(:birthday).ensure_valid
    obtain_specified_date
    @age = calculate_age
    @moon_age = calculate_moon_age
  end

  def display
    if @age < 1
      puts "生後 #{@moon_age}ヶ月"
    elsif @age < 2
      puts "#{@age}歳 #{@moon_age}ヶ月"
    else
      puts "#{@age}歳"
    end
  end

  private

  def obtain_specified_date
    @specified_date = DateSanitizer.new(:specified_date).ensure_valid
    return unless @birthday > @specified_date

    puts '指定日は誕生日より後にしてください'
    obtain_specified_date
  end

  def calculate_age
    (@specified_date - @birthday) / 10_000
  end

  def calculate_moon_age
    birthday_monthday = @birthday % 10_000
    specified_monthday = @specified_date % 10_000
    moon_age = (specified_monthday - birthday_monthday) / 100
    moon_age += 12 if moon_age.negative?
    moon_age
  end
end

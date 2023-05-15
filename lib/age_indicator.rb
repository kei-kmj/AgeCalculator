require './lib/date_sanitizer'

class AgeIndicator
  def initialize
    @birthday = DateSanitizer.new(:birthday).ensure_valid
    obtain_specified_date
  end

  def display
    age = calculate_age
    moon_age = calculate_moon_age

    if age < 1
      puts "生後 #{moon_age}ヶ月"
    elsif age < 2
      puts "#{age}歳 #{moon_age}ヶ月"
    else
      puts "#{age}歳"
    end
  end

  private

  def obtain_specified_date
    loop do
      @specified_date = DateSanitizer.new(:specified_date).ensure_valid
      break if @birthday <= @specified_date
      puts "指定日は誕生日より後にしてください"
    end
  end

  def calculate_age
    (@specified_date - @birthday) / 10000
  end

  def calculate_moon_age
    birthday_monthday = @birthday % 10000
    specified_monthday = @specified_date % 10000
    moon_age = (specified_monthday - birthday_monthday) / 100
    moon_age += 12 if moon_age < 0
    moon_age
  end
end
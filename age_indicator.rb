require './formatted_date'

class AgeIndicator
  def initialize
    @birthday = FormattedDate.new(:birthday).format
    @specified_date = FormattedDate.new(:specified_day).format
  end

  def calculate_age
    if @birthday > @specified_date
      puts "指定日は誕生日より後にしてください"
      @specified_date = FormattedDate.new(:specified_day).format
    end

    age = (@specified_date - @birthday) / 10000
    puts "あなたは#{age}歳です"
  end

  def calculate_moon_age
    birthday_monthday = @birthday % 10000
    specified_monthday = @specified_date % 10000
    moon_age = (specified_monthday - birthday_monthday) / 100
    moon_age += 12 if moon_age < 0

    puts "あなたは#{moon_age}ヶ月です"
  end
end
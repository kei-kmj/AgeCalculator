require "./input_guide"

class Day
  def initialize(date_type)
    @date_type = date_type
    @day = validated_day
  end

  def value
    @day
  end

  private

  def validated_day
    InputGuide.prompt_day(@date_type)
    day = gets.to_i
    return day if day.between?(1, 31)
    puts "1から31までの数字で入力してください"
    validated_day
  end
end
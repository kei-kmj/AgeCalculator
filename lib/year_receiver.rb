require "./lib/input_guide"

class YearReceiver
  def initialize(date_type)
    @date_type = date_type
    @year = validated_year
  end

  def value
    @year
  end

  private

  def validated_year
    InputGuide.prompt_year(@date_type)
    year = gets.to_i
    return year if year.between?(1, 9999)
    puts "西暦の年(1-9999)として正しい数字を入力してください"
    validated_year
  end
end
require "./input_guide"

class Year
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
    return year if year.between?(0, 9999)
    puts "西暦の年として正しい数字を入力してください"
    validated_year
  end
end
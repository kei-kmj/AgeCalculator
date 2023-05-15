class MonthReceiver
  def initialize(date_type)
    @date_type = date_type
    @month = validated_month
  end

  def value
    @month
  end
  private

  def validated_month
    InputGuide.prompt_month(@date_type)
    month = gets.to_i
    return month if month.between?(1, 12)
    puts "1から12までの数字で入力してください"
    validated_month
  end
end
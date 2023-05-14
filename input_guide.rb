class InputGuide
  def self.prompt_year(date_type)
    puts "#{date_type == :birthday ? '誕生' : '指定'}年を西暦で入力してください"
  end

  def self.prompt_month(date_type)
    puts "#{date_type == :birthday ? '誕生' : '指定'}月を西暦で入力してください"
  end

  def self.prompt_day(date_type)
    puts "#{date_type == :birthday ? '誕生' : '指定'}日を西暦で入力してください"
  end
end
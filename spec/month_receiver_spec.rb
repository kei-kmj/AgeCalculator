require_relative '../lib/month_receiver'

describe 'Month' do
  it '1桁の数字を受け取ることが出来る' do
    allow_any_instance_of(Object).to receive(:gets).and_return("1")

    month = MonthReceiver.new(:specified_date)

    expect(month.value).to eq 1
  end

  it '12以下の数字を受け取ることが出来る' do
    allow_any_instance_of(Object).to receive(:gets).and_return("12")

    month = MonthReceiver.new(:specified_date)

    expect(month.value).to eq 12
  end

  it '0が入力されたら再入力を求め、有効な値を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return("0", "1")

    month = MonthReceiver.new(:birthday)

    expect { month.send(:validated_month) }.to output("誕生月を1-12の数字で入力してください\n").to_stdout
    expect(month.value).to eq 1
  end

  it '13以上が入力されたら再入力を求め、有効な値を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return("13", "10")

    month = MonthReceiver.new(:birthday)

    expect { month.send(:validated_month) }.to output("誕生月を1-12の数字で入力してください\n").to_stdout
    expect(month.value).to eq 10
  end

  it '文字列が入力されたら再入力を求め、有効な値を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return("ab", "10")

    month = MonthReceiver.new(:birthday)

    expect { month.send(:validated_month) }.to output("誕生月を1-12の数字で入力してください\n").to_stdout
    expect(month.value).to eq 10
  end
end
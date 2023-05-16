# frozen_string_literal: true

require_relative '../lib/day_receiver'

describe 'DayReceiver' do
  it '1桁の数字を受け取ることが出来る' do
    allow_any_instance_of(Object).to receive(:gets).and_return('1')

    day = DayReceiver.new(:specified_date)

    expect(day.value).to eq 1
  end

  it '31以下の数字を受け取ることが出来る' do
    allow_any_instance_of(Object).to receive(:gets).and_return('31')

    day = DayReceiver.new(:specified_date)

    expect(day.value).to eq 31
  end

  it '0が入力されたら再入力を求め、有効な日を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return('0', '1')

    day = DayReceiver.new(:birthday)

    expect { day.send(:validated_day) }.to output("誕生日を1-31の数字で入力してください\n").to_stdout
    expect(day.value).to eq 1
  end

  it '32以上が入力されたら再入力を求め、有効な日を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return('32', '31')

    day = DayReceiver.new(:birthday)

    expect { day.send(:validated_day) }.to output("誕生日を1-31の数字で入力してください\n").to_stdout
    expect(day.value).to eq 31
  end

  it '文字列が入力されたら再入力を求め、有効な日を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return('ab', '10')

    day = DayReceiver.new(:birthday)

    expect { day.send(:validated_day) }.to output("誕生日を1-31の数字で入力してください\n").to_stdout
    expect(day.value).to eq 10
  end
end

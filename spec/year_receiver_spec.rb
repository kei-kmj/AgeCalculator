# frozen_string_literal: true

require_relative '../lib/year_receiver'

describe 'YearReceiver' do
  it '1桁の数字を受け取ることが出来る' do
    allow_any_instance_of(Object).to receive(:gets).and_return('2')

    year = YearReceiver.new(:specified_date)

    expect(year.value).to eq 2
  end

  it '4桁以下の数字を受け取ることが出来る' do
    allow_any_instance_of(Object).to receive(:gets).and_return('2000')

    year = YearReceiver.new(:specified_date)

    expect(year.value).to eq 2000
  end

  it '0が入力されたときは再入力を求め、有効な年を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return('0', '1')

    year = YearReceiver.new(:birthday)

    expect { year.send(:validated_year) }.to output("誕生年を西暦で入力してください\n").to_stdout
    expect(year.value).to eq 1
  end

  it '4桁を越えたときは再入力を求め、有効な年を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return('10000', '2000')

    year = YearReceiver.new(:birthday)

    expect { year.send(:validated_year) }.to output("誕生年を西暦で入力してください\n").to_stdout
    expect(year.value).to eq 2000
  end

  it '文字列が入力されたら再入力させて、有効な値を返す' do
    allow_any_instance_of(Object).to receive(:gets).and_return('abcd', '2000')

    year = YearReceiver.new(:birthday)

    expect(year.value).to eq 2000
  end
end

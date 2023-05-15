require_relative '../lib/age_indicator'

describe 'AgeIndicator' do
  it '誕生日を指定日にすると”生後 0ヶ月"と表示される' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 20000101)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("生後 0ヶ月\n").to_stdout
  end

  it '1歳未満は月齢が表示される' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 20001231)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("生後 11ヶ月\n").to_stdout
  end
  it '1歳を越えると年齢と月齢が表示される' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 20010101)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("1歳 0ヶ月\n").to_stdout
  end

  it '2歳未満は年齢と月齢が表示される' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 20011231)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("1歳 11ヶ月\n").to_stdout
  end

  it '2歳になると年齢が表示される' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 20020101)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("2歳\n").to_stdout
  end

  it '2歳以上の時は年齢が表示される' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 20230515)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("23歳\n").to_stdout
  end

  it '西暦9999年まで計算できる' do
    birthday = double('DateSanitizer', format: 00000101)
    specified_date = double('DateSanitizer', format: 99991231)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output("9999歳\n").to_stdout
  end
  it '誕生日より前の日にちを指定日にすると、もう一度指定日の入力を求める' do
    birthday = double('DateSanitizer', format: 20000101)
    specified_date = double('DateSanitizer', format: 19991231)

    allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
    allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

    age_indicator = AgeIndicator.new

    expect { age_indicator.display_age }.to output(/^指定日は誕生日より後にしてください/).to_stdout
  end

  describe 'うるう年の確認' do
    it '2月29日生まれは翌年2月28日まで生後11ヶ月' do
      birthday = double('DateSanitizer', format: 20200229)
      specified_date = double('DateSanitizer', format: 20210228)

      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

      age_indicator = AgeIndicator.new

      expect { age_indicator.display_age }.to output("生後 11ヶ月\n").to_stdout
    end

    it '2月29日生まれは翌年の3月1日に1歳になる' do
      birthday = double('DateSanitizer', format: 20200229)
      specified_date = double('DateSanitizer', format: 20210301)

      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

      age_indicator = AgeIndicator.new

      expect { age_indicator.display_age }.to output("1歳 0ヶ月\n").to_stdout
    end
  end

  describe '月末の確認' do
    it '1月31日生まれは2月28日には生後 0ヶ月' do
      birthday = double('DateSanitizer', format: 20200131)
      specified_date = double('DateSanitizer', format: 20200228)

      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

      age_indicator = AgeIndicator.new

      expect { age_indicator.display_age }.to output("生後 0ヶ月\n").to_stdout
    end

    it '1月31日生まれは3月1日に生後1ヶ月になる' do
      birthday = double('DateSanitizer', format: 20200131)
      specified_date = double('DateSanitizer', format: 20200301)

      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date)

      age_indicator = AgeIndicator.new

      expect { age_indicator.display_age }.to output("生後 1ヶ月\n").to_stdout
    end
  end
end

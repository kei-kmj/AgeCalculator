# frozen_string_literal: true

require_relative '../lib/age_indicator'
describe 'AgeIndicator' do
  describe '1歳未満の確認' do
    let(:birthday_sanitizer) { double('DateSanitizer') }
    let(:specified_date_sanitizer) { double('DateSanitizer') }
    let(:age_indicator) { AgeIndicator.new }

    before do
      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday_sanitizer)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date_sanitizer)
      allow(birthday_sanitizer).to receive(:ensure_valid).and_return(20_000_101)
    end
    it '誕生日=指定日のとき生後 0ヶ月' do
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_000_101)

      expect { age_indicator.display }.to output("生後 0ヶ月\n").to_stdout
    end

    it '1歳の誕生日の前日は生後11ヶ月' do
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_001_231)

      expect { age_indicator.display }.to output("生後 11ヶ月\n").to_stdout
    end
  end

  describe '2歳未満の確認' do
    let(:birthday_sanitizer) { double('DateSanitizer') }
    let(:specified_date_sanitizer) { double('DateSanitizer') }
    let(:age_indicator) { AgeIndicator.new }

    before do
      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday_sanitizer)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date_sanitizer)
      allow(birthday_sanitizer).to receive(:ensure_valid).and_return(20_000_101)
    end

    it '1歳を越えると年齢と月齢が表示される' do
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_010_101)

      expect { age_indicator.display }.to output("1歳 0ヶ月\n").to_stdout
    end

    it '2歳未満は年齢と月齢が表示される' do
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_011_231)

      expect { age_indicator.display }.to output("1歳 11ヶ月\n").to_stdout
    end
  end

  describe '2歳以上の確認' do
    let(:birthday_sanitizer) { double('DateSanitizer') }
    let(:specified_date_sanitizer) { double('DateSanitizer') }
    let(:age_indicator) { AgeIndicator.new }

    before do
      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday_sanitizer)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date_sanitizer)
      allow(birthday_sanitizer).to receive(:ensure_valid).and_return(20_000_101)
    end

    it '2歳になると年齢が表示される' do
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_020_101)

      expect { age_indicator.display }.to output("2歳\n").to_stdout
    end

    it '2歳以上の時は年齢が表示される' do
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_230_515)

      expect { age_indicator.display }.to output("23歳\n").to_stdout
    end

    it '西暦9999年まで計算できる' do
      allow(birthday_sanitizer).to receive(:ensure_valid).and_return(10_101)
      allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(99_991_231)

      expect { age_indicator.display }.to output("9998歳\n").to_stdout
    end
  end
  describe 'うるう年の確認' do
    let(:birthday_sanitizer) { double('DateSanitizer') }
    let(:specified_date_sanitizer) { double('DateSanitizer') }
    let(:age_indicator) { AgeIndicator.new }

    before do
      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday_sanitizer)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date_sanitizer)
      allow(birthday_sanitizer).to receive(:ensure_valid).and_return(20_200_229)
    end

    context '2月29日の場合' do
      it '翌年2月28日は生後11ヶ月' do
        allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_210_228)

        expect { age_indicator.display }.to output("生後 11ヶ月\n").to_stdout
      end

      it '翌年の3月1日に1歳になる' do
        allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(20_210_301)

        expect { age_indicator.display }.to output("1歳 0ヶ月\n").to_stdout
      end
    end
  end

  describe '月末の確認' do
    let(:birthday_sanitizer) { double('DateSanitizer') }
    let(:specified_date_sanitizer) { double('DateSanitizer') }
    let(:age_indicator) { AgeIndicator.new }

    before do
      allow(DateSanitizer).to receive(:new).with(:birthday).and_return(birthday_sanitizer)
      allow(DateSanitizer).to receive(:new).with(:specified_date).and_return(specified_date_sanitizer)
      allow(birthday_sanitizer).to receive(:ensure_valid).and_return(202_001_31)
    end

    context '1月31日生まれの場合' do
      it '2月28日には生後 0ヶ月と表示される' do
        allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(202_002_28)

        expect { age_indicator.display }.to output("生後 0ヶ月\n").to_stdout
      end

      it '3月1日に生後1ヶ月になると表示される' do
        allow(specified_date_sanitizer).to receive(:ensure_valid).and_return(202_003_01)

        expect { age_indicator.display }.to output("生後 1ヶ月\n").to_stdout
      end
    end
  end
end

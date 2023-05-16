require_relative '../lib/date_sanitizer'

describe 'DateSanitizer' do
  let(:date_sanitizer) { DateSanitizer.new(:specified_date) }

  before do
    allow_any_instance_of(YearReceiver).to receive(:gets).and_return(year)
    allow_any_instance_of(MonthReceiver).to receive(:gets).and_return(month)
    allow_any_instance_of(DayReceiver).to receive(:gets).and_return(day)
  end

  describe '#formatted' do
    context "西暦1桁" do
      let(:year) { 1 }
      let(:month) { 2 }
      let(:day) { 1 }

      it "5桁の整数を返す" do
        expect(date_sanitizer.send(:formatted)).to eq 10201
      end
    end
    context "西暦4桁" do
      let(:year) { 9999 }
      let(:month) { 12 }
      let(:day) { 31 }

      it "8桁の整数を返す" do
        expect(date_sanitizer.send(:formatted)).to eq 99991231
      end
    end
  end
  describe "#valid?" do
    context "2020年はうるう年" do
      let(:year) { 2020 }
      let(:month) { 2 }
      let(:day) { 29 }

      it "trueが返る" do
        expect(date_sanitizer.send(:valid?)).to be true
      end
    end

    context "2019年はうるう年ではない" do
      let(:year) { 2019 }
      let(:month) { 2 }
      let(:day) { 29 }

      it "falseが返る" do
        expect(date_sanitizer.send(:valid?)).to be false
      end
    end

    context "2023/4/31は有効な日付ではない" do
      let(:year) { 2023 }
      let(:month) { 4 }
      let(:day) { 31 }

      it "falseが返る" do
        expect(date_sanitizer.send(:valid?)).to be false
      end
    end
  end
end

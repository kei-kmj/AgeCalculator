require_relative '../lib/year_receiver'

describe 'Year' do
    context '正しい年が入力された場合' do
      it 'その年を返す' do
        allow_any_instance_of(Object).to receive(:gets).and_return("2000")

        year = YearReceiver.new(:specified_date)

        expect(year.value).to eq 2000
      end
    end

    context '不正な年が入力された場合' do
      it '誕生年の再入力を求め、その後正しい年を返す' do
        allow_any_instance_of(Object).to receive(:gets).and_return("10000", "2000")

        year = YearReceiver.new(:birthday)

        expect { year.send(:validated_year) }.to output("誕生年を西暦で入力してください\n").to_stdout
        expect(year.value).to eq 2000
      end

      it '指定年の再入力を求め、その後正しい年を返す' do
        allow_any_instance_of(Object).to receive(:gets).and_return("10000", "2000")

        year = YearReceiver.new(:specified_date)

        expect { year.send(:validated_year) }.to output("指定年を西暦で入力してください\n").to_stdout
        expect(year.value).to eq 2000
      end
    end

    context '文字列が入力された場合' do
      it '誕生年の再入力を求める' do
        allow_any_instance_of(Object).to receive(:gets).and_return("abcd", "2000")

        year = YearReceiver.new(:birthday)

        expect { year.send(:validated_year) }.to output("誕生年を西暦で入力してください\n").to_stdout
        expect(year.value).to eq 2000
      end

      it '指定年の再入力を求める' do
        allow_any_instance_of(Object).to receive(:gets).and_return("abcd", "2000")

        year = YearReceiver.new(:specified_date)

        expect { year.send(:validated_year) }.to output("指定年を西暦で入力してください\n").to_stdout
        expect(year.value).to eq 2000
      end
    end
end
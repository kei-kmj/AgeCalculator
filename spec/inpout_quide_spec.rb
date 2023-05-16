require_relative '../lib/input_guide'

describe InputGuide do
  describe '.prompt_year' do
    context 'date_typeが:birthdayのとき' do
      it '誕生年の入力を促す' do
        expect { InputGuide.prompt_year(:birthday) }.to output("誕生年を西暦で入力してください\n").to_stdout
      end
    end

    context 'date_typeが:specified_dateのとき' do
      it '指定日の入力を促す' do
        expect { InputGuide.prompt_year(:specified_date) }.to output("指定年を西暦で入力してください\n").to_stdout
      end
    end

    describe '.prompt_month' do
      context 'date_typeが:birthdayのとき' do
        it '誕生月の入力を促す' do
          expect { InputGuide.prompt_month(:birthday) }.to output("誕生月を1-12の数字で入力してください\n").to_stdout
        end
      end
      context 'date_typeが:specified_dateのとき' do
        it '指定月の入力を促す' do
          expect { InputGuide.prompt_month(:specified_date) }.to output("指定月を1-12の数字で入力してください\n").to_stdout
        end
      end
    end
    describe '.prompt_day' do
      context 'date_typeが:birthdayのとき' do
        it '誕生日の入力を促す' do
          expect { InputGuide.prompt_day(:birthday) }.to output("誕生日を1-31の数字で入力してください\n").to_stdout
        end
      end
      context 'date_typeが:specified_dateのとき' do
        it '指定日の入力を促す' do
          expect { InputGuide.prompt_day(:specified_date) }.to output("指定日を1-31の数字で入力してください\n").to_stdout
        end
      end
    end
  end
end

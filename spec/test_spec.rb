
RSpec.describe AgeIndicator do
  describe "#calculate_age" do
    context "when birthday is 1990/01/01 and specified day is 2020/01/01" do
      it "returns 30" do
        allow_any_instance_of(FormattedDate).to receive(:format).and_return(19900101, 20200101)
        expect { AgeIndicator.new.calculate_age }.to output("あなたは30歳です\n").to_stdout
      end
    end

    context "when birthday is 1990/01/01 and specified day is 2020/01/02" do
      it "returns 29" do
        allow_any_instance_of(FormattedDate).to receive(:format).and_return(19900101, 20200102)
        expect { AgeIndicator.new.calculate_age }.to output("あなたは29歳です\n").to_stdout
      end
    end

    context "when birthday is 1990/01/01 and specified day is 2020/12/31" do
      it "returns 29" do
        allow_any_instance_of(FormattedDate).to receive(:format).and_return(19900101, 20201231)
        expect { AgeIndicator.new.calculate_age }.to output("あなたは29歳です\n").to_stdout
      end
    end

    context "when birthday is 1990/01/01 and specified day is 2021/01/01" do
      it "returns 30" do
        allow_any_instance_of(FormattedDate).to receive(:format).and_return(19900101, 20210101)
        expect { AgeIndicator.new.calculate_age }.to output("あなたは30歳です\n").to_stdout
      end
    end

    context "when birthday is 1990/01/01 and specified day is 2021/01/02" do
      it "returns 30" do
        allow_any_instance_of(FormattedDate).to receive(:format).and_return(19900101, 20210102)
        expect { AgeIndicator.new.calculate_age }.to output("あなたは30歳です\n").to_stdout
      end
    end

    context "when birthday is 1990/01/01 and specified day is 2021/12/31" do
      it "returns 30" do
        allow_any_instance_of(FormattedDate).to receive(:format).and_return(19900101, 20211231)
        expect { AgeIndicator.new.calculate_age }.to output("あなたは30歳です\n").to_stdout
      end
    end
  end
end

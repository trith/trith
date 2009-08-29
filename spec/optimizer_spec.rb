require 'trith'

include  Trith

describe Optimizer do
  describe Optimizer::LiteralCanonicalization do
    it "should canonicalize :nil instructions" do
      optimized[:nil].should == [nil]
    end

    it "should canonicalize :true and :false instructions" do
      optimized[:false].should == [false]
      optimized[:true].should  == [true]
    end
  end

  describe Optimizer::EmptyQuotationElimination do
    it "should replace empty quotations with the :nop instruction" do
      optimized[[]].should == [:nop]
      optimized[true, [], [], :branch].should == [true, :nop, :nop, :branch]
    end
  end

  describe Optimizer::QuotationFactoring do
    it "should convert quotations into gensym definitions" do
      optimized[[]].first.should be_instance_of(Symbol)
      optimized[[:+], :call].first.should be_instance_of(Symbol)
    end
  end

  describe Optimizer::ConstantArithmeticFolding do
    it "should evaluate constant integer negation" do
      optimized[-1, :neg].should == [1]
      optimized[ 0, :neg].should == [0]
      optimized[ 1, :neg].should == [-1]
    end

    it "should evaluate constant integer increments" do
      optimized[-1, :inc].should == [0]
      optimized[ 0, :inc].should == [1]
      optimized[ 1, :inc].should == [2]
    end

    it "should evaluate constant integer decrements" do
      optimized[-1, :dec].should == [-2]
      optimized[ 0, :dec].should == [-1]
      optimized[ 1, :dec].should == [0]
    end

    it "should evaluate constant integer addition" do
      optimized[1, 2, :+].should == [3]
    end

    it "should evaluate constant integer subtraction" do
      optimized[4, 5, :-].should == [-1]
    end

    it "should evaluate constant integer multiplication" do
      optimized[6, 7, :*].should == [42]
    end

    it "should evaluate constant integer division when the remainder is zero" do
      optimized[8, 1, :'/'].should == [8]
      optimized[8, 4, :'/'].should == [2]
    end

    it "should not evaluate constant integer division when the remainder is not zero" do
      optimized[8, 3, :'/'].should == [8, 3, :'/']
    end

    it "should evaluate constant integer modulo and remainder operations" do
      optimized[ 13,  4, :mod].should == [1]
      optimized[ 13,  4, :rem].should == [1]
      optimized[ 13, -4, :mod].should == [-3]
      optimized[ 13, -4, :rem].should == [1]
      optimized[-13,  4, :mod].should == [3]
      optimized[-13,  4, :rem].should == [-1]
      optimized[-13, -4, :mod].should == [-1]
      optimized[-13, -4, :rem].should == [-1]
    end

    it "should evaluate constant integer exponentiation" do
      optimized[2, 0, :pow].should == [1]
      optimized[2, 1, :pow].should == [2]
      optimized[2, 4, :pow].should == [16]
    end

    it "should evaluate constant integer absolute values" do
      optimized[ 0, :abs].should == [0]
      optimized[ 1, :abs].should == [1]
      optimized[-1, :abs].should == [1]
    end
  end

  describe Optimizer::ConstantComparisonFolding do
    it "should evaluate constant comparison operations" do
      optimized[-1, 0, :cmp].should == [-1]
      optimized[ 0, 0, :cmp].should == [0]
      optimized[ 1, 0, :cmp].should == [1]

      optimized[-1, 0, :eq].should == [false]
      optimized[ 0, 0, :eq].should == [true]
      optimized[ 1, 0, :eq].should == [false]

      optimized[-1, 0, :ne].should == [true]
      optimized[ 0, 0, :ne].should == [false]
      optimized[ 1, 0, :ne].should == [true]

      %w(== < <= > >=).map(&:to_sym).each do |op| # FIXME
        optimized[-1, 0, op].should == [-1.send(op, 0)]
        optimized[ 0, 0, op].should == [ 0.send(op, 0)]
        optimized[ 1, 0, op].should == [ 1.send(op, 0)]
      end
    end
  end

  def optimized
    proxy = OpenStruct.new(:example => self)
    class << proxy
      def [](*instructions)
        example.optimize(*instructions)
      end
    end
    proxy
  end

  def optimize(*input)
    described_class.transform(Program.new(:input => input)).definitions[:input]
  end
end

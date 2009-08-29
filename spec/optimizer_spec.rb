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

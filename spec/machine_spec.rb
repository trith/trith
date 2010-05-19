require File.join(File.dirname(__FILE__), 'spec_helper')

describe Trith::Machine do
  context "Execution operators" do
    it "should implement the :reset operator" do
      Machine.new.should respond_to(:reset)
      Machine.new([6, 7]).execute { reset }.to_a.should == []
    end

    it "should implement the :halt operator" do
      Machine.new.should respond_to(:halt)
      Machine.run { push(42).halt }.should == 42
    end

    it "should implement the :nop operator" do
      Machine.new.should respond_to(:nop, :',', :';')
      Machine.run { push(42).nop }.should == 42
    end

    it "should implement the :quote operator" do
      Machine.new.should respond_to(:quote, :'\\', :"'")
      # TODO
    end

    it "should implement the :call operator" do
      Machine.new.should respond_to(:call)
      # TODO
    end

    it "should implement the :times operator" do
      Machine.new.should respond_to(:times)
      # TODO
    end

    it "should implement the :twice operator" do
      Machine.new.should respond_to(:twice, :'2x')
      # TODO
    end

    it "should implement the :thrice operator" do
      Machine.new.should respond_to(:thrice, :'3x')
      # TODO
    end

    it "should implement the :loop operator" do
      Machine.new.should respond_to(:loop)
      # TODO
    end

    it "should implement the :while operator" do
      Machine.new.should respond_to(:while)
      # TODO
    end

    it "should implement the :until operator" do
      Machine.new.should respond_to(:until)
      # TODO
    end

    it "should implement the :branch operator" do
      Machine.new.should respond_to(:branch, :if)
      # TODO
    end

    it "should implement the :when operator" do
      Machine.new.should respond_to(:when)
      # TODO
    end

    it "should implement the :unless operator" do
      Machine.new.should respond_to(:unless)
      # TODO
    end
  end

  context "Stack shufflers" do
    it "should implement the :clear operator" do
      Machine.new.should respond_to(:clear)
      Machine.new([6, 7]).execute { clear }.stack.should == []
    end

    it "should implement the :depth operator" do
      Machine.new.should respond_to(:depth)
      # TODO
    end

    it "should implement the :stack operator" do
      Machine.new.should respond_to(:stack)
      # TODO
    end

    it "should implement the :unstack operator" do
      Machine.new.should respond_to(:unstack)
      # TODO
    end

    it "should implement the :drop operator" do
      Machine.new.should respond_to(:drop)
      Machine.new([6, 7]).execute { drop }.stack.should == [6]
    end

    it "should implement the :drop2 operator" do
      Machine.new.should respond_to(:drop2, :'2drop')
      # TODO
    end

    it "should implement the :drop3 operator" do
      Machine.new.should respond_to(:drop3, :'3drop')
      # TODO
    end

    it "should implement the :dup operator" do
      Machine.new.should respond_to(:dup)
      Machine.new([6, 7]).execute { dup }.stack.should == [6, 7, 7]
    end

    it "should implement the :dup2 operator" do
      Machine.new.should respond_to(:dup2, :'2dup')
      # TODO
    end

    it "should implement the :dup3 operator" do
      Machine.new.should respond_to(:dup3, :'3dup')
      # TODO
    end

    it "should implement the :swap operator" do
      Machine.new.should respond_to(:swap)
      Machine.new([6, 7]).execute { swap }.stack.should == [7, 6]
    end

    it "should implement the :nip operator" do
      Machine.new.should respond_to(:nip)
      # TODO
    end

    it "should implement the :nip2 operator" do
      Machine.new.should respond_to(:nip2, :'2nip')
      # TODO
    end

    it "should implement the :over operator" do
      Machine.new.should respond_to(:over)
      # TODO
    end

    it "should implement the :pick operator" do
      Machine.new.should respond_to(:pick)
      # TODO
    end

    it "should implement the :rot operator" do
      Machine.new.should respond_to(:rot)
      # TODO
    end
  end

  context "Stack combinators" do
    it "should implement the :dip operator" do
      Machine.new.should respond_to(:dip)
      Machine.new([6, 7, 1, [:mul]]).execute { dip }.stack.should == [42, 1]
    end
  end

  context "Arithmetic operators" do
    it "should implement the :abs operator" do
      Machine.new.should respond_to(:abs)
      Machine.run { push(1).abs }.should == 1
      Machine.run { push(-1).abs }.should == 1
    end

    it "should implement the :neg operator" do
      Machine.new.should respond_to(:neg)
      Machine.run { push(6).neg }.should == -6
    end

    it "should implement the :inc operator" do
      Machine.new.should respond_to(:inc)
      Machine.run { push(6).inc }.should == 7
    end

    it "should implement the :dec operator" do
      Machine.new.should respond_to(:dec)
      Machine.run { push(6).dec }.should == 5
    end

    it "should implement the :add operator" do
      Machine.new.should respond_to(:add, :+)
      Machine.run { push(6).push(7).add }.should == 13
    end

    it "should implement the :sub operator" do
      Machine.new.should respond_to(:sub, :-)
      Machine.run { push(6).push(7).sub }.should == -1
    end

    it "should implement the :mul operator" do
      Machine.new.should respond_to(:mul, :*)
      Machine.run { push(6).push(7).mul }.should == 42
    end

    it "should implement the :div operator" do
      Machine.new.should respond_to(:div, :'/')
      Machine.run { push(42).push(7).div }.should == 6
    end

    it "should implement the :rem operator" do
      Machine.new.should respond_to(:rem)
      # TODO
    end

    it "should implement the :mod operator" do
      Machine.new.should respond_to(:mod)
      # TODO
    end

    it "should implement the :pow operator" do
      Machine.new.should respond_to(:pow)
      # TODO
    end
  end

  context "Bitwise operators" do
    it "should implement the :not operator" do
      Machine.new.should respond_to(:not)
      # TODO
    end

    it "should implement the :and operator" do
      Machine.new.should respond_to(:and)
      # TODO
    end

    it "should implement the :or operator" do
      Machine.new.should respond_to(:or)
      # TODO
    end

    it "should implement the :xor operator" do
      Machine.new.should respond_to(:xor)
      # TODO
    end

    it "should implement the :shl operator" do
      Machine.new.should respond_to(:shl)
      # TODO
    end

    it "should implement the :shr operator" do
      Machine.new.should respond_to(:shr)
      # TODO
    end
  end

  context "Boolean predicates" do
    it "should implement the :nilp operator" do
      Machine.new.should respond_to(:nilp, :nil?)
      # TODO
    end

    it "should implement the :boolp operator" do
      Machine.new.should respond_to(:boolp, :bool?)
      # TODO
    end

    it "should implement the :falsep operator" do
      Machine.new.should respond_to(:falsep, :false?)
      # TODO
    end

    it "should implement the :truep operator" do
      Machine.new.should respond_to(:truep, :true?)
      # TODO
    end

    it "should implement the :notp operator" do
      Machine.new.should respond_to(:notp, :not?)
      # TODO
    end

    it "should implement the :andp operator" do
      Machine.new.should respond_to(:andp, :and?)
      # TODO
    end

    it "should implement the :orp operator" do
      Machine.new.should respond_to(:orp, :or?)
      # TODO
    end

    it "should implement the :xorp operator" do
      Machine.new.should respond_to(:xorp, :xor?)
      # TODO
    end
  end

  context "Boolean constructors" do
    it "should implement the :nil operator" do
      Machine.new.should respond_to(:nil)
      # TODO
    end

    it "should implement the :bool operator" do
      Machine.new.should respond_to(:bool)
      # TODO
    end

    it "should implement the :false operator" do
      Machine.new.should respond_to(:false)
      # TODO
    end

    it "should implement the :true operator" do
      Machine.new.should respond_to(:true)
      # TODO
    end
  end

  context "Comparison operators" do
    it "should implement the :cmp operator" do
      Machine.new.should respond_to(:cmp, :<=>)
      # TODO
    end

    it "should implement the :eq operator" do
      Machine.new.should respond_to(:eq, :'=')
      # TODO
    end

    it "should implement the :ne operator" do
      Machine.new.should respond_to(:ne, :'!=')
      # TODO
    end

    it "should implement the :lt operator" do
      Machine.new.should respond_to(:lt, :<)
      # TODO
    end

    it "should implement the :le operator" do
      Machine.new.should respond_to(:le, :<=)
      # TODO
    end

    it "should implement the :gt operator" do
      Machine.new.should respond_to(:gt, :>)
      # TODO
    end

    it "should implement the :ge operator" do
      Machine.new.should respond_to(:ge, :>=)
      # TODO
    end

    it "should implement the :min operator" do
      Machine.new.should respond_to(:min)
      # TODO
    end

    it "should implement the :max operator" do
      Machine.new.should respond_to(:max)
      # TODO
    end
  end

  context "Numeric predicates" do
    it "should implement the :nump operator" do
      Machine.new.should respond_to(:nump, :num?)
      # TODO
    end

    it "should implement the :intp operator" do
      Machine.new.should respond_to(:intp, :int?)
      # TODO
    end

    it "should implement the :infp operator" do
      Machine.new.should respond_to(:infp, :inf?)
      # TODO
    end

    it "should implement the :zerop operator" do
      Machine.new.should respond_to(:zerop, :zero?)
      # TODO
    end

    it "should implement the :onep operator" do
      Machine.new.should respond_to(:onep, :one?)
      # TODO
    end

    it "should implement the :negp operator" do
      Machine.new.should respond_to(:negp, :neg?)
      # TODO
    end

    it "should implement the :posp operator" do
      Machine.new.should respond_to(:posp, :pos?)
      # TODO
    end

    it "should implement the :oddp operator" do
      Machine.new.should respond_to(:oddp, :odd?)
      # TODO
    end

    it "should implement the :evenp operator" do
      Machine.new.should respond_to(:evenp, :even?)
      # TODO
    end
  end

  context "Numeric constructors" do
    it "should implement the :num operator" do
      Machine.new.should respond_to(:num)
      # TODO
    end

    it "should implement the :int operator" do
      Machine.new.should respond_to(:int)
      # TODO
    end

    it "should implement the :inf operator" do
      Machine.new.should respond_to(:inf)
      # TODO
    end
  end

  context "Math constants" do
    it "should implement the :pi operator" do
      Machine.new.should respond_to(:pi)
      # TODO
    end
  end

  context "Math operators" do
    it "should implement the :ceil operator" do
      Machine.new.should respond_to(:ceil)
      # TODO
    end

    it "should implement the :floor operator" do
      Machine.new.should respond_to(:floor)
      # TODO
    end

    it "should implement the :round operator" do
      Machine.new.should respond_to(:round)
      # TODO
    end

    it "should implement the :sq operator" do
      Machine.new.should respond_to(:sq)
      # TODO
    end

    it "should implement the :sqrt operator" do
      Machine.new.should respond_to(:sqrt)
      # TODO
    end

    it "should implement the :cb operator" do
      Machine.new.should respond_to(:cb)
      # TODO
    end

    it "should implement the :cbrt operator" do
      Machine.new.should respond_to(:cbrt)
      # TODO
    end

    it "should implement the :exp operator" do
      Machine.new.should respond_to(:exp)
      # TODO
    end

    it "should implement the :log operator" do
      Machine.new.should respond_to(:log)
      # TODO
    end

    it "should implement the :log2 operator" do
      Machine.new.should respond_to(:log2)
      # TODO
    end

    it "should implement the :log10 operator" do
      Machine.new.should respond_to(:log10)
      # TODO
    end

    it "should implement the :hypot operator" do
      Machine.new.should respond_to(:hypot)
      # TODO
    end

    it "should implement the :cos operator" do
      Machine.new.should respond_to(:cos)
      # TODO
    end

    it "should implement the :cosh operator" do
      Machine.new.should respond_to(:cosh)
      # TODO
    end

    it "should implement the :sin operator" do
      Machine.new.should respond_to(:sin)
      # TODO
    end

    it "should implement the :sinh operator" do
      Machine.new.should respond_to(:sinh)
      # TODO
    end

    it "should implement the :tan operator" do
      Machine.new.should respond_to(:tan)
      # TODO
    end

    it "should implement the :tanh operator" do
      Machine.new.should respond_to(:tanh)
      # TODO
    end

    it "should implement the :acos operator" do
      Machine.new.should respond_to(:acos)
      # TODO
    end

    it "should implement the :acosh operator" do
      Machine.new.should respond_to(:acosh)
      # TODO
    end

    it "should implement the :asin operator" do
      Machine.new.should respond_to(:asin)
      # TODO
    end

    it "should implement the :asinh operator" do
      Machine.new.should respond_to(:asinh)
      # TODO
    end

    it "should implement the :atan operator" do
      Machine.new.should respond_to(:atan)
      # TODO
    end

    it "should implement the :atan2 operator" do
      Machine.new.should respond_to(:atan2)
      # TODO
    end

    it "should implement the :atanh operator" do
      Machine.new.should respond_to(:atanh)
      # TODO
    end
  end

  context "Sequence predicates" do
    it "should implement the :seqp operator" do
      Machine.new.should respond_to(:seqp)
      # TODO
    end

    it "should implement the :emptyp operator" do
      Machine.new.should respond_to(:emptyp)
      # TODO
    end

    it "should implement the :memberp operator" do
      Machine.new.should respond_to(:memberp)
      # TODO
    end

    it "should implement the :anyp operator" do
      Machine.new.should respond_to(:anyp)
      # TODO
    end

    it "should implement the :allp operator" do
      Machine.new.should respond_to(:allp)
      # TODO
    end
  end

  context "Sequence constructors" do
    it "should implement the :seq operator" do
      Machine.new.should respond_to(:seq)
      # TODO
    end

    it "should implement the :cons operator" do
      Machine.new.should respond_to(:cons)
      # TODO
    end

    it "should implement the :list operator" do
      Machine.new.should respond_to(:list)
      # TODO
    end

    it "should implement the :iota operator" do
      Machine.new.should respond_to(:iota)
      # TODO
    end

    it "should implement the :range operator" do
      Machine.new.should respond_to(:range)
      # TODO
    end

    it "should implement the :repeat operator" do
      Machine.new.should respond_to(:repeat)
      # TODO
    end

    it "should implement the :cycle operator" do
      Machine.new.should respond_to(:cycle)
      # TODO
    end
  end

  context "Sequence accessors" do
    it "should implement the :length operator" do
      Machine.new.should respond_to(:length)
      # TODO
    end

    it "should implement the :rest operator" do
      Machine.new.should respond_to(:rest)
      # TODO
    end

    it "should implement the :first operator" do
      Machine.new.should respond_to(:first)
      # TODO
    end

    it "should implement the :second operator" do
      Machine.new.should respond_to(:second)
      # TODO
    end

    it "should implement the :third operator" do
      Machine.new.should respond_to(:third)
      # TODO
    end

    it "should implement the :fourth operator" do
      Machine.new.should respond_to(:fourth)
      # TODO
    end

    it "should implement the :fifth operator" do
      Machine.new.should respond_to(:fifth)
      # TODO
    end

    it "should implement the :sixth operator" do
      Machine.new.should respond_to(:sixth)
      # TODO
    end

    it "should implement the :seventh operator" do
      Machine.new.should respond_to(:seventh)
      # TODO
    end

    it "should implement the :eighth operator" do
      Machine.new.should respond_to(:eighth)
      # TODO
    end

    it "should implement the :ninth operator" do
      Machine.new.should respond_to(:ninth)
      # TODO
    end

    it "should implement the :tenth operator" do
      Machine.new.should respond_to(:tenth)
      # TODO
    end

    it "should implement the :nth operator" do
      Machine.new.should respond_to(:nth)
      # TODO
    end

    it "should implement the :last operator" do
      Machine.new.should respond_to(:last)
      # TODO
    end
  end

  context "Sequence operators" do
    it "should implement the :subseq operator" do
      Machine.new.should respond_to(:subseq)
      # TODO
    end

    it "should implement the :concat operator" do
      Machine.new.should respond_to(:concat)
      # TODO
    end

    it "should implement the :uniq operator" do
      Machine.new.should respond_to(:uniq)
      # TODO
    end

    it "should implement the :reverse operator" do
      Machine.new.should respond_to(:reverse)
      # TODO
    end

    it "should implement the :sort operator" do
      Machine.new.should respond_to(:sort)
      # TODO
    end

    it "should implement the :sortby operator" do
      Machine.new.should respond_to(:sortby)
      # TODO
    end

    it "should implement the :flatten operator" do
      Machine.new.should respond_to(:flatten)
      # TODO
    end

    it "should implement the :zip operator" do
      Machine.new.should respond_to(:zip)
      # TODO
    end

    it "should implement the :zip1 operator" do
      Machine.new.should respond_to(:zip1)
      # TODO
    end

    it "should implement the :zip2 operator" do
      Machine.new.should respond_to(:zip2)
      # TODO
    end

    it "should implement the :zip3 operator" do
      Machine.new.should respond_to(:zip3)
      # TODO
    end

    it "should implement the :zip4 operator" do
      Machine.new.should respond_to(:zip4)
      # TODO
    end

    it "should implement the :unzip operator" do
      Machine.new.should respond_to(:unzip)
      # TODO
    end

    it "should implement the :unzip1 operator" do
      Machine.new.should respond_to(:unzip1)
      # TODO
    end

    it "should implement the :unzip2 operator" do
      Machine.new.should respond_to(:unzip2)
      # TODO
    end

    it "should implement the :unzip3 operator" do
      Machine.new.should respond_to(:unzip3)
      # TODO
    end

    it "should implement the :unzip4 operator" do
      Machine.new.should respond_to(:unzip4)
      # TODO
    end
  end

  context "Sequence combinators" do
    it "should implement the :each operator" do
      Machine.new.should respond_to(:each)
      # TODO
    end

    it "should implement the :map operator" do
      Machine.new.should respond_to(:map)
      Machine.new([[1, 2, 3, 4, 5], [:dup, :mul]]).execute { map }.stack.should == [[1, 4, 9, 16, 25]]
    end

    it "should implement the :count operator" do
      Machine.new.should respond_to(:count)
      # TODO
    end

    it "should implement the :filter operator" do
      Machine.new.should respond_to(:filter)
      Machine.new([[1, 2, 3, 4, 5], [2, :mod, 0, :eq]]).execute { filter }.stack.should == [[2, 4]]
    end

    it "should implement the :remove operator" do
      Machine.new.should respond_to(:remove)
      # TODO
    end

    it "should implement the :foldl operator" do
      Machine.new.should respond_to(:foldl)
      Machine.new([[1, 2, 3, 4, 5], 0, [:add]]).execute { foldl }.stack.should == [15]
      Machine.new([[], -1, [:add]]).execute { foldl }.stack.should == [-1]
      Machine.new([[2, 5, 3], 0, [:add]]).execute { foldl }.stack.should == [10]
      Machine.new([[2, 5, 3], 0, [:dup, :mul, :add]]).execute { foldl }.stack.should == [38]
    end

    it "should implement the :foldr operator" do
      Machine.new.should respond_to(:foldr)
      # TODO
    end
  end

  context "Textual predicates" do
    it "should implement the :chrp operator" do
      Machine.new.should respond_to(:chrp, :chr?)
      # TODO
    end

    # TODO
  end

  context "Textual constructors" do
    it "should implement the :chr operator" do
      Machine.new.should respond_to(:chr)
      Machine.run([97])  { chr }.should == "a"
      Machine.run([960]) { chr }.should == "\u03c0" # PI
    end

    # TODO
  end

  context "Textual operators" do
    it "should implement the :size operator" do
      Machine.new.should respond_to(:size)
      # TODO
    end
  end

  context "Output operators" do
    it "should implement the :print operator" do
      Machine.new.should respond_to(:print)
      # TODO
    end
  end
end

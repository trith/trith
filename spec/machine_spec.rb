require File.join(File.dirname(__FILE__), 'spec_helper')

describe Trith::Machine do
  context "Queue operators" do
    it "should support the :nop instruction" do
      Machine.new.should respond_to(:nop)
      Machine.execute { push(42).nop }.should == 42
    end

    it "should support the :halt instruction" do
      Machine.new.should respond_to(:halt)
      Machine.execute { push(42).halt }.should == 42
    end

    it "should support the :call instruction" do
      Machine.new.should respond_to(:call)
      # TODO
    end

    it "should support the :loop instruction" do
      Machine.new.should respond_to(:loop)
      # TODO
    end

    it "should support the :branch instruction" do
      Machine.new.should respond_to(:branch)
      # TODO
    end
  end

  context "Stack operators" do
    it "should support the :reset instruction" do
      Machine.new.should respond_to(:reset)
      Machine.new([6, 7]).execute { reset }.stack.should == []
    end

    it "should support the :pop instruction" do
      Machine.new.should respond_to(:pop)
      Machine.new([6, 7]).execute { pop }.stack.should == [6]
    end

    it "should support the :dup instruction" do
      Machine.new.should respond_to(:dup)
      Machine.new([6, 7]).execute { dup }.stack.should == [6, 7, 7]
    end

    it "should support the :swap instruction" do
      Machine.new.should respond_to(:swap)
      Machine.new([6, 7]).execute { swap }.stack.should == [7, 6]
    end
  end

  context "Stack combinators" do
    it "should support the :dip instruction" do
      Machine.new.should respond_to(:dip)
      Machine.new([6, 7, 1, [:mul]]).execute { dip }.stack.should == [42, 1]
    end
  end

  context "List combinators" do
    it "should support the :map instruction" do
      Machine.new.should respond_to(:map)
      Machine.new([[1, 2, 3, 4, 5], [:dup, :mul]]).execute { map }.stack.should == [[1, 4, 9, 16, 25]]
    end

    it "should support the :filter instruction" do
      Machine.new.should respond_to(:filter)
      Machine.new([[1, 2, 3, 4, 5], [2, :mod, 0, :eq]]).execute { filter }.stack.should == [[2, 4]]
    end

    it "should support the :fold instruction" do
      Machine.new.should respond_to(:fold)
      Machine.new([[1, 2, 3, 4, 5], 0, [:add]]).execute { fold }.stack.should == [15]
      Machine.new([[], -1, [:add]]).execute { fold }.stack.should == [-1]
      Machine.new([[2, 5, 3], 0, [:add]]).execute { fold }.stack.should == [10]
      Machine.new([[2, 5, 3], 0, [:dup, :mul, :add]]).execute { fold }.stack.should == [38]
    end
  end

  context "Arithmetic operators" do
    it "should support the :neg instruction" do
      Machine.new.should respond_to(:neg)
      Machine.execute { push(6).neg }.should == -6
    end

    it "should support the :inc instruction" do
      Machine.new.should respond_to(:inc)
      Machine.execute { push(6).inc }.should == 7
    end

    it "should support the :dec instruction" do
      Machine.new.should respond_to(:dec)
      Machine.execute { push(6).dec }.should == 5
    end

    it "should support the :add instruction" do
      Machine.new.should respond_to(:add)
      Machine.execute { push(6).push(7).add }.should == 13
    end

    it "should support the :sub instruction" do
      Machine.new.should respond_to(:sub)
      Machine.execute { push(6).push(7).sub }.should == -1
    end

    it "should support the :mul instruction" do
      Machine.new.should respond_to(:mul)
      Machine.execute { push(6).push(7).mul }.should == 42
    end

    it "should support the :div instruction" do
      Machine.new.should respond_to(:div)
      Machine.execute { push(42).push(7).div }.should == 6
    end

    it "should support the :rem instruction" do
      Machine.new.should respond_to(:rem)
      # TODO
    end

    it "should support the :mod instruction" do
      Machine.new.should respond_to(:mod)
      # TODO
    end

    it "should support the :pow instruction" do
      Machine.new.should respond_to(:pow)
      # TODO
    end

    it "should support the :abs instruction" do
      Machine.new.should respond_to(:abs)
      # TODO
    end

    it "should support the :min instruction" do
      Machine.new.should respond_to(:min)
      # TODO
    end

    it "should support the :max instruction" do
      Machine.new.should respond_to(:max)
      # TODO
    end
  end

  context "Bitwise operators" do
    it "should support the :not instruction" do
      Machine.new.should respond_to(:not)
      # TODO
    end

    it "should support the :and instruction" do
      Machine.new.should respond_to(:and)
      # TODO
    end

    it "should support the :or instruction" do
      Machine.new.should respond_to(:or)
      # TODO
    end

    it "should support the :xor instruction" do
      Machine.new.should respond_to(:xor)
      # TODO
    end

    it "should support the :shl instruction" do
      Machine.new.should respond_to(:shl)
      # TODO
    end

    it "should support the :shr instruction" do
      Machine.new.should respond_to(:shr)
      # TODO
    end
  end

  context "Comparison operators" do
    it "should support the :cmp instruction" do
      Machine.new.should respond_to(:cmp)
      # TODO
    end

    it "should support the :eq instruction" do
      Machine.new.should respond_to(:eq)
      # TODO
    end

    it "should support the :ne instruction" do
      Machine.new.should respond_to(:ne)
      # TODO
    end

    it "should support the :lt instruction" do
      Machine.new.should respond_to(:lt)
      # TODO
    end

    it "should support the :le instruction" do
      Machine.new.should respond_to(:le)
      # TODO
    end

    it "should support the :gt instruction" do
      Machine.new.should respond_to(:gt)
      # TODO
    end

    it "should support the :ge instruction" do
      Machine.new.should respond_to(:ge)
      # TODO
    end
  end
end

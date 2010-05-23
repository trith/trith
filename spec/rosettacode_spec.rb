# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')

# @see http://rosettacode.org/wiki/Category:Trith
describe "Rosetta Code examples" do
  before(:each) { @stdout, $stdout = $stdout, StringIO.new }
  after(:each)  { $stdout = @stdout }

  # @see http://rosettacode.org/wiki/Empty_program#Trith
  context "Empty program" do
    it "should work" do
      lambda { Machine.run(Reader.read_all("")) }.should_not raise_error
    end
  end

  # @see http://rosettacode.org/wiki/Hello_world/Text#Trith
  context "Hello world/Text" do
    it "should work using :print" do
      code = Reader.read_all(<<-EOF)
        "Goodbye, World!" print
      EOF
      Machine.run(code).should be_nil
      $stdout.string.should == "Goodbye, World!\n"
    end
  end

  # @see http://rosettacode.org/wiki/Sum_and_product_of_an_array#Trith
  context "Sum and product of an array" do
    it "should work using :+ and :foldl" do
      code = Reader.read_all(<<-EOF)
        [1 2 3 4 5] 0 [+] foldl
      EOF
      Machine.run(code).should == 15
    end

    it "should work using :* and :foldl" do
      code = Reader.read_all(<<-EOF)
        [1 2 3 4 5] 1 [*] foldl
      EOF
      Machine.run(code).should == 120
    end
  end

  # @see http://rosettacode.org/wiki/Singly-linked_list/Traversal#Trith
  context "Singly-linked list/Traversal" do
    it "should work using :each" do
      code = Reader.read_all(<<-EOF)
        [1 2 3 4 5] [print] each
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "1\n2\n3\n4\n5\n"
    end
  end

  # @see http://rosettacode.org/wiki/Loops/Infinite#Trith
  context "Loops/Infinite" do
    it "should work using :loop" do
      code = Reader.read_all(<<-EOF)
        ["SPAM" print] loop
      EOF
      #Machine.run(code).should == nil # FIXME: need a timeout/step limit
    end
  end

  # @see http://rosettacode.org/wiki/Loops/Foreach#Trith
  context "Loops/Foreach" do
    it "should work using :each" do
      code = Reader.read_all(<<-EOF)
        [1 2 3 4 5] [print] each
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "1\n2\n3\n4\n5\n"
    end
  end

  # @see http://rosettacode.org/wiki/Loops/While#Trith
  context "Loops/While" do
    it "should work using :/ and :floor" do
      code = Reader.read_all(<<-EOF)
        1024 [dup print 2 / floor] [dup 0 >] while drop
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "1024\n512\n256\n128\n64\n32\n16\n8\n4\n2\n1\n"
    end

    it "should work using :shr" do
      code = Reader.read_all(<<-EOF)
        1024 [dup print 1 shr] [dup 0 >] while drop
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "1024\n512\n256\n128\n64\n32\n16\n8\n4\n2\n1\n"
    end
  end

  # @see http://rosettacode.org/wiki/Loops/Downward_for#Trith
  context "Loops/Downward for" do
    it "should work using :each" do
      code = Reader.read_all(<<-EOF)
        10 inc iota reverse [print] each
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "10\n9\n8\n7\n6\n5\n4\n3\n2\n1\n0\n"
    end

    it "should work using :while" do
      code = Reader.read_all(<<-EOF)
        10 [dup print dec] [dup 0 >=] while drop
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "10\n9\n8\n7\n6\n5\n4\n3\n2\n1\n0\n"
    end
  end

  # @see http://rosettacode.org/wiki/Flatten_a_list#Trith
  context "Flatten a list" do
    it "should work using :flatten" do
      code = Reader.read_all(<<-EOF)
        [[1] 2 [[3 4] 5] [[[]]] [[[6]]] 7 8 []] flatten
      EOF
      Machine.run(code).should == [1, 2, 3, 4, 5, 6, 7, 8]
    end
  end

  # @see http://rosettacode.org/wiki/Array_concatenation#Trith
  context "Array concatenation" do
    it "should work using :concat" do
      code = Reader.read_all(<<-EOF)
        [1 2 3] [4 5 6] concat
      EOF
      Machine.run(code).should == [1, 2, 3, 4, 5, 6]
    end
  end

  # @see http://rosettacode.org/wiki/Copy_a_string#Trith
  context "Copy a string" do
    it "should work using :dup" do
      code = Reader.read_all(<<-EOF)
        "Hello" dup
      EOF
      Machine.run(code).should == "Hello"
    end
  end

  # @see http://rosettacode.org/wiki/Generic_swap#Trith
  context "Generic swap" do
    it "should work using :swap" do
      code = Reader.read_all(<<-EOF)
        swap
      EOF
      Machine.run([1, 2] + code).should == 1
    end
  end

  # @see http://rosettacode.org/wiki/String_length#Trith
  context "String length" do
    it "should work using :length" do
      code = Reader.read_all(<<-EOF)
        "møøse" length
      EOF
      Machine.run(code).should == 5
    end

    it "should work using :size" do
      code = Reader.read_all(<<-EOF)
        "møøse" size
      EOF
      Machine.run(code).should == 7
    end
  end

  # @see http://rosettacode.org/wiki/Higher-order_functions#Trith
  context "Higher-order functions" do
    it "should work using :twice" do
      code = Reader.read_all(<<-EOF)
        : twice 2 times ;
        : hello "Hello, world!" print ;
        [hello] twice
      EOF
      Machine.run(code).should == nil # FIXME
      $stdout.string.should == "Hello, world!\nHello, world!\n"
    end
  end

  # @see http://rosettacode.org/wiki/Conditional_structures#Trith
  context "Conditional structures" do
    it "should work using :branch" do
      code = Reader.read_all(<<-EOF)
        true ["yes" print] ["no" print] branch
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "yes\n"
    end

    it "should work using :when" do
      code = Reader.read_all(<<-EOF)
        true ["yes" print] when
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "yes\n"
    end

    it "should work using :unless" do
      code = Reader.read_all(<<-EOF)
        false ["no" print] unless
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "no\n"
    end
  end

  # @see http://rosettacode.org/wiki/Boolean_values#Trith
  context "Boolean values" do
    it "should work" # TODO
  end

  # @see http://rosettacode.org/wiki/Infinity#Trith
  context "Infinity" do
    it "should work" do
      code = Reader.read_all(<<-EOF)
        : inf 1.0 0.0 / ;
        : -inf inf neg ;
        : inf? abs inf = ;
      EOF
      Machine.run(code).should == nil # FIXME
    end
  end

  # @see http://rosettacode.org/wiki/Character_codes#Trith
  context "Character codes" do
    it "should work with ASCII" do
      code = Reader.read_all(<<-EOF)
        "a" ord print
        97 chr print
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "97\na\n"
    end

    it "should work with Unicode" do
      code = Reader.read_all(<<-EOF)
        "π" ord print
        960 chr print
      EOF
      Machine.run(code).should == nil
      $stdout.string.should == "960\nπ\n"
    end
  end

  # @see http://rosettacode.org/wiki/Greatest_element_of_a_list#Trith
  context "Greatest element of a list" do
    it "should work using :max and :foldl1" do
      code = Reader.read_all(<<-EOF)
        [1 -2 3.1415 0 42 7] [max] foldl1
      EOF
      Machine.run(code).should == 42
    end
  end

  # @see http://rosettacode.org/wiki/Sum_of_squares#Trith
  context "Sum of squares" do
    it "should work using :foldl" do
      code = Reader.read_all(<<-EOF)
        [3 1 4 1 5 9] 0 [dup * +] foldl
      EOF
      Machine.run(code).should == 133
    end
  end

  # @see http://rosettacode.org/wiki/Averages/Arithmetic_mean#Trith
  context "Averages/Arithmetic mean" do
    it "should work using :foldl1" do
      code = Reader.read_all(<<-EOF)
        : mean dup empty? [drop 0] [dup [+] foldl1 swap length /] branch ;
        [3 1 4 1 5 9] mean
      EOF
      Machine.run(code).should == 3 # FIXME
    end
  end

  # @see http://rosettacode.org/wiki/Category:Trith_examples_needing_attention
  # @see http://rosettacode.org/wiki/Reports:Tasks_not_implemented_in_Trith
end

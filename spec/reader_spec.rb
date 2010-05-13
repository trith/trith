require File.join(File.dirname(__FILE__), 'spec_helper')

describe Trith::Reader do
  it "should not be instantiable" do
    lambda { Trith::Reader.new }.should raise_error(NoMethodError)
  end

  it "should support reading URLs" do
    Trith::Reader.should respond_to(:read_url)
    # TODO
  end

  it "should support reading files" do
    Trith::Reader.should respond_to(:read_files)
    Trith::Reader.should respond_to(:read_file)
    # TODO
  end

  it "should support reading IO objects" do
    Trith::Reader.should respond_to(:read)
    # TODO
  end

  it "should support reading StringIO objects" do
    Trith::Reader.should respond_to(:read)
    lambda { Trith::Reader.read(StringIO.new('123')) }.should_not raise_error
    # TODO
  end

  it "should support reading strings" do
    Trith::Reader.should respond_to(:read)
    lambda { Trith::Reader.read('123') }.should_not raise_error
    # TODO
  end
end

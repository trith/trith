require 'trith'

include  Trith

require 'trith/sys/posix'
describe System::POSIX do
  before(:each) do
    @machine = Machine.new { import Trith::System::POSIX }
  end

  context "Time operations" do
    it "should support the :time operation" do
      @machine.should respond_to(:time)
      @machine.execute { time }.pop.should be_a(Integer)
      @machine.stack.should be_empty
    end
  end

  context "File operations" do
    it "should support the :stdin operation" do
      @machine.should respond_to(:stdin)
      @machine.execute { stdin }.pop.should == $stdin
      @machine.stack.should be_empty
    end

    it "should support the :stdout operation" do
      @machine.should respond_to(:stdout)
      @machine.execute { stdout }.pop.should == $stdout
      @machine.stack.should be_empty
    end

    it "should support the :stderr operation" do
      @machine.should respond_to(:stderr)
      @machine.execute { stderr }.pop.should == $stderr
      @machine.stack.should be_empty
    end

    it "should support the :fileno operation" do
      @machine.should respond_to(:fileno)
      @machine.execute([$stderr]) { fileno }.pop.should == 2
      @machine.stack.should be_empty
    end

    it "should support the :fopen operation"
    it "should support the :fseek operation"

    it "should support the :fread operation" do
      @machine.should respond_to(:fwrite)
      @machine.execute([__FILE__, 'r']) { fopen }.peek.should be_a(IO)
      @machine.execute(["require 'trith'".length]) { fread }.pop.should == "require 'trith'"
      @machine.stack.should be_empty
    end

    it "should support the :fwrite operation" do
      buffer = StringIO.new
      @machine.should respond_to(:fwrite)
      @machine.execute([buffer, "Hello, world!\n"]) { fwrite }.pop.should be_an(Integer)
      buffer.string.should == "Hello, world!\n"
      @machine.stack.should be_empty
    end

    it "should support the :feof operation"
    it "should support the :fflush operation"
    it "should support the :fclose operation"
    it "should support the :fsync operation"
    it "should support the :popen operation"
    it "should support the :pclose operation"
  end
end
  
module Trith module System
  module POSIX
    def time
      push Time.new.to_i          # => Integer
    end

    def stdin
      push $stdin                 # => IO
    end

    def stdout
      push $stdout                # => IO
    end

    def stderr
      push $stderr                # => IO
    end

    def fileno(io)
      io.fileno                   # => int
    end

    def fopen(filename, mode)
      Kernel.open(filename, mode) # => IO
    end

    def fseek(io, pos)
      io.seek(pos)                # => 0 | -1
    end

    def fread(io, count)
      io.read(count)              # => String | nil
    end

    def fwrite(io, text)
      io.write(text)              # => Integer
    end

    def feof(io)
      io.eof?                     # => true | false
    end

    def fflush(io)
      io.flush                    # => IO
      nil
    end

    def fclose(io)
      io.close                    # => nil
    end

    def fsync(fd)
      IO.new(fd, 'w').fsync       # => 0 | -1
    end

    def popen(command, mode)
      IO.popen(command, mode)     # => IO
    end

    def pclose(io)
      io.close                    # => nil
    end
  end
end end

require 'openssl' unless defined?(::OpenSSL)

module Trith module Library
  module OpenSSL
    include ::OpenSSL

    def rand_bytes
      push Random.random_bytes(count)   # => String
    end

    def md4(data)
      Digest::MD4.hexdigest(data)       # => String
    end

    def md5(data)
      Digest::MD5.hexdigest(data)       # => String
    end

    def ripemd160(data)
      Digest::RIPEMD160.hexdigest(data) # => String
    end

    def sha1(data)
      Digest::SHA1.hexdigest(data)      # => String
    end

    def sha224(data)
      Digest::SHA224.hexdigest(data)    # => String
    end

    def sha256(data)
      Digest::SHA256.hexdigest(data)    # => String
    end

    def sha384(data)
      Digest::SHA384.hexdigest(data)    # => String
    end

    def sha512(data)
      Digest::SHA512.hexdigest(data)    # => String
    end
  end
end end

require 'digest'

module Auth
  module Model
    DEFAULT_PEPPER     = ENV['LOGIN_PEPER']      || '3xDe1c640'
    RANDOM_HEX_LENGTH  = ENV['LOGIN_HEX_LENGTH'] || 6

    def random_hex
      SecureRandom.hex(RANDOM_HEX_LENGTH)
    end

    def generate_hex_pair(plain_string)
      salt = random_hex
      {
        salt: salt,
        hex: password_hex(plain_string, salt)
      }
    end

    def password_hex(string, salt)
      sha = Digest::SHA256.new
      sha.hexdigest(encryption_string(string, salt))
    end

    private

    def encryption_string(string, salt)
      "#{pepperize_string(string)}#{salt}"
    end

    def pepperize_string(string)
      "#{DEFAULT_PEPPER}#{string}"
    end

  end
end

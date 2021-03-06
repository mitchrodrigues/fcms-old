require 'digest'

module Auth
  module Model
    DEFAULT_PEPPER     = '3de1c690'
    RANDOM_HEX_LENGTH  = 4

    def random_hex
      SecureRandom.hex(RANDOM_HEX_LENGTH) # Hard code for now
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

require 'auth/model'

# This will allow us to portal people in 
# allow logins for families etc, to complete paperwork
class Person < ActiveRecord::Base
  include Assignable
  include Notable

  include Auth::Model
  include Addressable
  include Permissable
  
  has_permissions
  has_addresses
  has_paper_trail
  has_notes

  ALLOWED_ATTRIBUTES = [
    :first_name,
    :middle_name,
    :last_name,
    :social
  ]

  #######################################################
  # Rails STI to Polymorphic hax
  #######################################################
  # This is a bug when mixing sti and abstract_classes
  # however not having abstract breaks the poloymorphic
  # relationing in assignments table. so lets just set it :)
  # why not. This seems to fix the bug well enough.
  self.abstract_class = true
  self.table_name     = 'people'
  def self.inherited(subclass)
    super
    subclass.instance_eval do
      default_scope ->() { where(type: subclass.name) }
      def type
        subclass.name
      end
    end
  end

  before_create :stupid_rails_bug_fix
  def stupid_rails_bug_fix
    self.type = self.class.to_s
  end

  #######################################################
  # Relations
  #######################################################

  belongs_to :organization

  #######################################################
  # Validations
  #######################################################

  validates_uniqueness_of :email, allow_blank: true

  #######################################################
  # Callbacks
  #######################################################

  before_save :encrypt_password

  def encrypt_password
  	return true unless password.present?  	
    if password_changed?
      pair = generate_hex_pair(password)
      self.salt     = pair[:salt]
      self.password = pair[:hex]
    end
  end

  #######################################################
  # Instance Methods
  #######################################################

  ## Password
  
  def password_match?(pass_string)
    password_hex(pass_string, salt) == password
  end

  def as_json
    attributes.except('password', 'salt')
  end
  
  def subject
    "#{first_name} #{last_name}"
  end

  #######################################################
  # Class Methods
  #######################################################
  class << self
    def login(email, password, ip_addr = 'unknown')
      user = where(email: email).first

      return nil unless user.present?
      return nil unless user.password_match?(password)
      
      # user.update_login_info(ip_addr)

      user
    end

    def name_search_clause(name_str)
      pieces = name_str.split(' ')
      case pieces.length
      when 1
        first_or_last_clause(pieces[0])
      when 2
        first_and_last_clause(*pieces)
      end
    end

    private

    def first_or_last_clause(name_str)
      ["first_name LIKE ? OR last_name LIKE ?"] + (["#{name_str}%"]*2)
    end

    def first_and_last_clause(piece1, piece2)
      query = "(first_name = ? AND last_name = ?) OR (last_name = ? AND first_name = ?)"
      [query] + [piece1, piece2]*2
    end

  end

end

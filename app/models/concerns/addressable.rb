module Addressable
  extend ActiveSupport::Concern

  class_methods do
    def has_addresses
      has_many :address_relations, as: :owner
      has_many :addresses, through: :address_relations
    end    
  end

  def current_addresses
    @current_addresses ||= address_relations.where(ended_at: nil)
  end

  def primary_address
    @primary_address ||= address_relations.where(ended_at: nil, primary: true).first.address
  end

  def find_or_create_address(**attributes)
    address = Address.where(attributes).first
    address ||= Address.create(attributes)    
  end

  def address_add(**attributes)
    parimary = attributes.delete(:primary)

    address_primary_end if parimary

    new_address = find_or_create_address(attributes)
    ar = address_relations.new(address_id: new_address.id, primary: parimary || false)
    address_relations << ar
  end

  def address_end(address)
    address.update_attribute(ended_at: Time.now)
  end

  def address_primary_end
    return false unless primary_address
    address_end(primary_address)
  end

end
json.extract! @office, :id, :name, :created_at, :updated_at
json.partial! 'v1/common/address', locals: { address: @office.primary_address }

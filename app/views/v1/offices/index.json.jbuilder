json.array!(@offices) do |office|
  json.extract! office, :id
  json.extract! office, :name
  json.url v1_office_url(office, format: :json)

  json.partial! 'v1/common/address', locals: { address: office.primary_address }  
end

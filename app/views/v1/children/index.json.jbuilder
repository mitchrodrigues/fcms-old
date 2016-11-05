json.array!(@children) do |children|
  json.extract! children, :id
  
  json.extract! children, :first_name
  json.extract! children, :middle_name
  json.extract! children, :last_name
  json.extract! children, :active

  json.url v1_children_url(children, format: :json)
end

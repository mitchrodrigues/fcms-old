json.array!(@children) do |children|
  json.extract! children, :id
  
  json.extract! children, :first_name
  json.extract! children, :middle_name
  json.extract! children, :last_name
  json.extract! children, :active

  json.case_workers do |cworkers|
    cworkers.array! children.staff do |staff_hash|
      json.extract! staff_hash, :id, :first_name, :last_name
    end
  end


  json.photo_url "http://fcms.sjc.taazoo.cc:8080/images/avatar.gif"

  # json.url v1_children_url(children, format: :json)
end

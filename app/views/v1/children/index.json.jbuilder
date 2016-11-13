json.array!(@children) do |children|
  
  json.extract! children, :id, :first_name, :middle_name, :last_name, :active

  json.case_workers do |cworkers|
    cworkers.array! children.staff do |staff_hash|
      json.extract! staff_hash, :id, :first_name, :last_name
      json.full_name staff_hash.subject
      json.primary children.primary_case_worker.id == staff_hash.id
    end  
  end

  if (place = children.current_placement).present?
    json.current_placement do |current_fac|
      json.partial! 'v1/facilities/placement', locals: { place:  place }
    end
  end

    json.photo_url "http://fcms.sjc.taazoo.cc:8080/images/avatar.gif"

  # json.url v1_children_url(children, format: :json)
end

json.success true
json.extract! @child, :id, :first_name, :middle_name, :last_name, :active, :dob, :age
json.photo_url 'http://fcms.sjc.taazoo.cc:8080/images/avatar.gif'

json.case_workers do |cworkers|
  cworkers.array! @child.staff do |staff_hash|
    json.extract! staff_hash, :id, :first_name, :last_name
    json.full_name staff_hash.subject

    json.primary @child.current_staff.id == staff_hash.id
  end  
end

json.relations do |relations|
  relations.array! @child.family do |family|
    json.extract!  family, :id, :first_name, :last_name
    json.full_name family.subject
  end
end

if @child.current_placement.present?
  json.current_placement do |current_fac|
    json.partial! 'v1/facilities/placement', locals: { place:  @child.current_placement }
  end
end

json.placements do |placement|
  placement.array! @child.inactive_placements do |place|
    json.partial! 'v1/facilities/placement', locals: { place: place }
  end
end
json.success true
json.extract! @child, :first_name, :middle_name, :last_name, :active, :dob, :type
json.photo_url 'http://fcms.sjc.taazoo.cc:8080/images/avatar.gif'

json.case_workers do |cworkers|
  cworkers.array! @child.staff do |staff_hash|
    json.extract! staff_hash, :id, :first_name, :last_name
  end  
end

json.placements do |placement|
  placement.array! @child.placements do |place|
    json.started_at place.started_at
    json.ended_at   place.ended_at
    json.facility do |res| 
      res.extract! place.resource, :name, :bed_count, :active
      res.current  place.ended_at.blank?
    end
  end
end
json.success true
json.extract! @child, :first_name, :middle_name, :last_name, :active, :dob, :type
json.case_workers do |cworkers|
  cworkers.array! @child.staff do |staff_hash|
    json.extract! staff_hash, :first_name, :last_name
  end  
end

json.placements do |placement|
  placement.array! @child.placements do |place|
    json.started_at place.started_at
    json.ended_at   place.ended_at
    json.resource do |res| 
      res.extract! place.resource, :name, :bed_count, :active
    end
  end
end

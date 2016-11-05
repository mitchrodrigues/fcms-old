json.owner owner
json.assignemnts do |ass|
  ass.array! assignments do |ass_hash|
     json.started_at ass_hash.started_at
     json.resource ass_hash.resource
  end
end
json.note do |nts|
  json.extract! note, :note, :privacy, :type, :id, :created_at
  json.creator do 
    json.first_name note.creator.first_name
    json.last_name  note.creator.last_name    
    json.id        note.creator_id
  end
end
json.notes do |nts|
  nts.array! notes do |note|
    json.extract! note, :note, :privacy, :type, :id
    json.creator do 
      json.full_name note.creator.subject
      json.id        note.creator_id
    end
  end
end
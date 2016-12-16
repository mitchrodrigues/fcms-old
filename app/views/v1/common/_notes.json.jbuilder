json.notes do |nts|
  nts.array! notes do |note|
    json.partial! 'v1/common/note', note: note
  end
end
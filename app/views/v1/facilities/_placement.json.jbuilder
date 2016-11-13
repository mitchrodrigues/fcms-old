
# next if place.id == @child.current_placement.id
json.placement_id place.id
json.started_at place.started_at
json.ended_at   place.ended_at

json.duration_words  distance_of_time_in_words(place.started_at, place.ended_at || Time.now)
json.duration_months place.duration
json.extract! place.resource, :id, :name, :bed_count
json.current  place.ended_at.blank?

json.total_placed   place.resource.placement_count
json.available_beds place.resource.available_bed_count
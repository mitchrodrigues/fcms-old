
# next if place.id == @child.current_placement.id

facility = place.resource

json.extract! facility, :id, :name, :bed_count
json.total_placed   facility.placement_count
json.available_beds facility.available_bed_count

json.placement_id place.id
json.started_at place.started_at
json.ended_at   place.ended_at

json.duration_words  distance_of_time_in_words(place.started_at, place.ended_at || Time.now)
json.duration_months place.duration

json.current  place.ended_at.blank?



if (address = facility.primary_address).present?
  json.partial! 'v1/common/address', locals: { address: address }
end
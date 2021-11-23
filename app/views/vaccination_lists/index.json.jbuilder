json.array!(@vaccination_lists) do |vaccination_list|
  json.id vaccination_list.vaccine.id
  json.title vaccination_list.vaccine.name
  json.start vaccination_list.start_date
  json.end vaccination_list.end_date
end
json.array!(@vaccination_lists) do |vaccination_list|
  if vaccination_list.date == nil
    json.id vaccination_list.vaccine.id
    json.title vaccination_list.vaccine.name + "接種可能"
    json.start vaccination_list.start_date
    json.end vaccination_list.end_date  
  elsif vaccination_list.date >= Date.today
    json.id vaccination_list.vaccine.id
    json.title vaccination_list.vaccine.name + "予定"
    json.start vaccination_list.date
    json.end vaccination_list.date
    json.color "green"
  else
    json.id vaccination_list.vaccine.id
    json.title vaccination_list.vaccine.name + "済"
    json.start vaccination_list.date
    json.end vaccination_list.date
    json.color "red"
  end
end


require 'nationbuilder'

client = NationBuilder::Client.new('aycc', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "contacted organising"

total_phone_calls=0
total_phone_calls_after_jan=0
unique_contacts=0

filter_wants_to_vol = {
  tag: "contacted:%20organising"
  }
  
wants_to_vol = client.call(:people_tags, :people, filter_wants_to_vol)
wants_to_vol_2 = NationBuilder::Paginator.new(client, wants_to_vol)


wants_to_vol_3 = []
  wants_to_vol_3 += wants_to_vol_2.body['results']
while wants_to_vol_2.next?
  wants_to_vol_2 = wants_to_vol_2.next
  wants_to_vol_3 += wants_to_vol_2.body['results']
 
end  

wants_to_vol_3.each do |wants_to_vol_4|
  person_id_wants_to_vol = wants_to_vol_4['id']
  
 #ANSWERED PHONE CALL
answered_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
    status: "answered",
   method: "phone_call",

  }
  
answered_phone_call_1 = client.call(:contacts, :index, answered_phone_call)
  answered_phone_call_2 = NationBuilder::Paginator.new(client, answered_phone_call_1)

  jan_01_18= Date.parse('2018-01-01')
puts "#{person_id_wants_to_vol} #{jan_01_18} yep" 

  
answered_phone_call_3 = []
  answered_phone_call_3 += answered_phone_call_2.body['results']

 while answered_phone_call_2.next?
  answered_phone_call_2 = answered_phone_call_2.next
  answered_phone_call_3 += answered_phone_call_2.body['results']

end  

  answered_phone_call_after_jan = answered_phone_call_3.select do |c|

  Date.parse(c['created_at']) >= jan_01_18
end

  #Prints just phone calls after 01/01/2018
puts "#{person_id_wants_to_vol} #{answered_phone_call_after_jan.count} Answered filtered"
   #Prints phone calls across time
  answered_phone_call_count_total=  answered_phone_call_3.count


  
  #Meaningful phone calls
  puts "starting meaningful contact"
  
  
  meaningful_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
  status: "meaningful_interaction",
    method: "phone_call"
    
  }
  
meaningful_phone_call_1 = client.call(:contacts, :index, meaningful_phone_call)
  meaningful_phone_call_2 = NationBuilder::Paginator.new(client, meaningful_phone_call_1)
  
meaningful_phone_call_3 = []
  meaningful_phone_call_3 += meaningful_phone_call_2.body['results']

 while meaningful_phone_call_2.next?
  meaningful_phone_call_2 = meaningful_phone_call_2.next
  meaningful_phone_call_3 += meaningful_phone_call_2.body['results']

end  

  # Meaningful calls after Jan 1st 2018
meaningful_phone_call_filtered = meaningful_phone_call_3.select do |xyz|

  Date.parse(xyz['created_at']) >= jan_01_18
end

puts "#{person_id_wants_to_vol} #{meaningful_phone_call_filtered.count} Meaninful filtered"

#Total meaningful calls - all time
   meaningful_phone_call_total= meaningful_phone_call_3.count

#NOT INTERESTED CALLS
  puts "starting not interested"
  
  
  not_interested_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
  status: "not_interested",
    method: "phone_call"
    
  }
  
not_interested_phone_call_1 = client.call(:contacts, :index, not_interested_phone_call)
  not_interested_phone_call_2 = NationBuilder::Paginator.new(client, not_interested_phone_call_1)
  
not_interested_phone_call_3 = []
  not_interested_phone_call_3 += not_interested_phone_call_2.body['results']

 while not_interested_phone_call_2.next?
  not_interested_phone_call_2 = not_interested_phone_call_2.next
  not_interested_phone_call_3 += not_interested_phone_call_2.body['results']

end  

  # Not interested calls after Jan 1st 2018
not_interested_phone_call_after_jan = not_interested_phone_call_3.select do |a|

  Date.parse(a['created_at']) >= jan_01_18
end

puts "#{person_id_wants_to_vol} #{not_interested_phone_call_after_jan.count} Not interested "

#Total not interested calls - all time
   not_interested_phone_call_total= not_interested_phone_call_3.count
  
#SEND INFO CALLS
  puts "starting send info"
  
  
 send_info_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
  status: "send_information",
    method: "phone_call"
    
  }
  
send_info_phone_call_1 = client.call(:contacts, :index, send_info_phone_call)
  send_info_phone_call_2 = NationBuilder::Paginator.new(client, send_info_phone_call_1)
  
send_info_phone_call_3 = []
  send_info_phone_call_3 += send_info_phone_call_2.body['results']

 while send_info_phone_call_2.next?
  send_info_phone_call_2 = send_info_phone_call_2.next
  send_info_phone_call_3 += send_info_phone_call_2.body['results']

end  

  # send_info calls after Jan 1st 2018
send_info_phone_call_after_jan = send_info_phone_call_3.select do |g|

  Date.parse(g['created_at']) >= jan_01_18
end

puts "#{person_id_wants_to_vol} #{send_info_phone_call_after_jan.count} Send Info"



#Total send_info calls - all time
   send_info_phone_call_total= send_info_phone_call_3.count

total_phone_calls_after_jan_individual=answered_phone_call_after_jan.count+meaningful_phone_call_filtered.count+send_info_phone_call_after_jan.count+not_interested_phone_call_after_jan.count

if total_phone_calls_after_jan_individual>0
  unique_contacts_counter=1

  else
  
  unique_contacts_counter=0
  
end

unique_contacts=unique_contacts+unique_contacts_counter

total_phone_calls_after_jan=answered_phone_call_after_jan.count+meaningful_phone_call_filtered.count+send_info_phone_call_after_jan.count+not_interested_phone_call_after_jan.count+total_phone_calls_after_jan
total_phone_calls=not_interested_phone_call_total+meaningful_phone_call_total+answered_phone_call_3.count+send_info_phone_call_total+total_phone_calls



end

#puts "#{all_calls}"
puts "total phone calls after JAN is #{total_phone_calls_after_jan}"
puts "total phone calls is #{total_phone_calls}"
puts "total unique contacts is #{unique_contacts}"

    
#contacts_3.each do |contacts_4|
  
 # email = contacts_4['email']    
  #id4 = contacts_4['person_id']
   
#puts "#{id4}" 

#end

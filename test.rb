

require 'nationbuilder'

client = NationBuilder::Client.new('aycc', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "finding wants to vols"

filter_wants_to_vol = {
  tag: "wants%20to:%20volunteer%202018"
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
  puts "#{person_id_wants_to_vol} #{answered_phone_call_count_total} Answered total"

  
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
  puts " #{person_id_wants_to_vol} #{meaningful_phone_call_total} Meaningful Total"

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

puts "#{person_id_wants_to_vol} #{not_interested_phone_call_after_jan.count} Not interested filtered"

#Total not interested calls - all time
   not_interested_phone_call_total= not_interested_phone_call_3.count
  puts " #{person_id_wants_to_vol} #{not_interested_phone_call_total} Not interested Total"
  
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

puts "#{person_id_wants_to_vol} #{send_info_phone_call_after_jan.count} no answer filtered"



#Total send_info calls - all time
   send_info_phone_call_total= send_info_phone_call_3.count
  puts " #{person_id_wants_to_vol} #{send_info_phone_call_total} No answer Total"


#NO ANSWER CALLS
  puts "starting no answers"
  
  
 no_answer_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
  status: "no_answer",
    method: "phone_call"
    
  }
  
no_answer_phone_call_1 = client.call(:contacts, :index, no_answer_phone_call)
  no_answer_phone_call_2 = NationBuilder::Paginator.new(client, no_answer_phone_call_1)
  
no_answer_phone_call_3 = []
  no_answer_phone_call_3 += no_answer_phone_call_2.body['results']

 while no_answer_phone_call_2.next?
  no_answer_phone_call_2 = no_answer_phone_call_2.next
  no_answer_phone_call_3 += no_answer_phone_call_2.body['results']

end  

  # no_answer calls after Jan 1st 2018
no_answer_phone_call_after_jan = no_answer_phone_call_3.select do |h|

  Date.parse(h['created_at']) >= jan_01_18
end

puts "#{person_id_wants_to_vol} #{no_answer_phone_call_after_jan.count} No answer filtered"




#Total no_answer calls - all time
   no_answer_phone_call_total= no_answer_phone_call_3.count
  puts " #{person_id_wants_to_vol} #{no_answer_phone_call_total} Send Info Total"


#LEFT MESSAGE CALLS
  puts "starting left message"
  
  
 left_message_phone_call = {
  person_id: "#{person_id_wants_to_vol}",
  status: "left_message",
    method: "phone_call"
    
  }
  
left_message_phone_call_1 = client.call(:contacts, :index, left_message_phone_call)
  left_message_phone_call_2 = NationBuilder::Paginator.new(client, left_message_phone_call_1)
  
left_message_phone_call_3 = []
  left_message_phone_call_3 += left_message_phone_call_2.body['results']

 while left_message_phone_call_2.next?
  left_message_phone_call_2 = left_message_phone_call_2.next
  left_message_phone_call_3 += left_message_phone_call_2.body['results']

end  

  # left_message calls after Jan 1st 2018
left_message_phone_call_after_jan = left_message_phone_call_3.select do |o|

  Date.parse(o['created_at']) >= jan_01_18
end

puts "#{person_id_wants_to_vol} #{left_message_phone_call_after_jan.count} No answer filtered"

#Total left_message calls - all time
   left_message_phone_call_total= left_message_phone_call_3.count
  puts " #{person_id_wants_to_vol} #{left_message_phone_call_total} Send Info Total"



#Total NO PICK UPS - INCLUDING ALL TYPES OF PICK UPS
total_no_pick_ups= no_answer_phone_call_after_jan.count+left_message_phone_call_after_jan.count
puts "#{person_id_wants_to_vol} #{total_no_pick_ups} Total NO Pickups"

#Total PICK UPS - INCLUDING ALL TYPES OF PICK UPS
total_pick_ups= meaningful_phone_call_filtered.count+answered_phone_call_after_jan.count+not_interested_phone_call_after_jan.count+send_info_phone_call_after_jan.count
puts "#{person_id_wants_to_vol} #{total_pick_ups} Total Pickups"

# TOTAL CALLS TO ONE PERSON
total_calls=total_pick_ups+total_no_pick_ups

#PICK UP RATE
#pick_up_rate=total_pick_ups/total_calls*100

custom_fields_to_be_added = {
  "person": {
    "no_answer_18": "#{total_no_pick_ups}",
  "answered_18": "#{total_pick_ups}",
    "total_calls_made_2018": "#{total_calls}",
     "id": "#{person_id_wants_to_vol}",
  }
}
  
  client.call(:people, :push, custom_fields_to_be_added)

#all_calls=all_calls+total_calls
end

#puts "#{all_calls}"
puts "thats everyone done"
  


    
#contacts_3.each do |contacts_4|
  
 # email = contacts_4['email']    
  #id4 = contacts_4['person_id']
   
#puts "#{id4}" 

#end

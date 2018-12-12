

require 'nationbuilder'

client = NationBuilder::Client.new('harrycossar', ENV['NATIONBUILDER_APIKEY'], retries: 8)

puts "finding wants to vols"

total_phone_calls=0
total_phone_calls_after_jan=0

filter_wants_to_vol = {
  tag: "contacted:%202018"
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
  

total_phone_calls_after_jan=answered_phone_call_after_jan.count+total_phone_calls_after_jan
total_phone_calls=answered_phone_call_3.count+total_phone_calls
  
end

#puts "#{all_calls}"
puts "total phone calls is #{total_phone_calls}"
  


    
#contacts_3.each do |contacts_4|
  
 # email = contacts_4['email']    
  #id4 = contacts_4['person_id']
   
#puts "#{id4}" 

#end

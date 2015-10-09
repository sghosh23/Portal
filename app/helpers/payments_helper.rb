module PaymentsHelper
  def result id
   if id.to_i == 1
     "successfull"
   elsif id.to_i == 2
     "Fail"
   elsif id.to_i == 3
      "Processor Unavailable"

   elsif id.to_i == 4
    "Entered"

   end
 end
end

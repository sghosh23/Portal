module UserHelper
  def delivery_method(id)
    id = id.to_i
    if id == 1
     "Email"
   elsif id == 2
     "Email and Papper"
   else
     "Paper"
   end
  end
end

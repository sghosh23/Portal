class Payment
  attr_reader :userid, :invoice, :contact, :email
  def initialize
    client_d = Client.new
    @client = client_d.client
  end

   def get_latest_payment(user_id)
     response = @client.call(:get_latest_payment, message: { user_id: user_id})
     if response.success?
       data = response.to_array(:get_latest_payment_response, :return).first
     end
   end

end

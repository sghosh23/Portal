class User
  attr_reader :user_id
    def initialize
      client_d = Client.new
      @client = client_d.client
    end

    def user_id(username)
      response = @client.call(:get_user_id, message: { username: username})
      if response.success?
        @user_id = response.to_array(:get_user_id_response, :return).first
      end
    end


   def authenticate(user_id, password)
     response = @client.call(:authenticate, message: {user_id: user_id, password: password})
     if response.success?
       data = response.to_array(:authenticate_response, :return).first
     end
   end
   def get_contact(user_id)
     contact_res = @client.call(:get_user_contacts_ws, message: { user_id: user_id })
     if contact_res.success?
       data = contact_res.to_array(:get_user_contacts_ws_response,:return).first

     end
   end

   def get_user(user_id)
     response = @client.call(:get_user_ws, message: { user_id: user_id})
     if response.success?
       @user = response.to_array(:get_user_ws_response, :return).first
     end
   end

   def update_contact(user_id, contact)
     response = @client.call(:update_user_contact, message: { user_id: user_id, type_id: 20, contact: contact })
    #  if response.success?
    #    @user = response.to_array(:get_user_ws_response, :return).first
    #  end
   end
   def get_password(username)
     response = @client.call(:get_new_password, message: {  entity_id: 10.to_s, username: username })
     if response
       @data = response
     end
   end
   def get_latest_invoice(user_id)
     invoice_data = @client.call(:get_latest_invoice, message: { user_id: user_id})
     if invoice_data.success?
       data = invoice_data.to_array(:get_latest_invoice_response, :return).first
       @invoice_data = data
     end
   end
   def get_order(id)
     order_data = @client.call(:get_order, message: { order_id: id})
     if order_data.success?
       data = order_data.to_array(:get_order_response, :return).first
       @order_data = data
     end
   end
end

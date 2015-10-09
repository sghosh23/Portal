class Payment

  def client
    Client.new.client

  end
   def get_latest_payment(user_id)
     response = client.call(:get_latest_payment, message: { user_id: user_id})
     if response.success?
       data = response.to_array(:get_latest_payment_response, :return).first
     end
   end

   def get_payment_by_date( user_id )
     response = client.call(:retrive_payment_ids_with_date, message: { user_id: user_id })
     if response.success?
       data = response.to_array(:retrive_payment_ids_with_date_response, :return)
     end
   end
   def get_payment(id)
     response = client.call(:get_payment, message: { payment_id: id})
     if response.success?
       data = response.to_array(:get_payment_response, :return).first
     end
   end
   def get_unpaid_invoices(user_id)
     response = client.call(:get_unpaid_invoices, message: { user_id: user_id})
     if response.success?
       data = response.to_array(:get_unpaid_invoices_response, :return)
     end
   end

   def process_payment
   end
   private
    def method_type?
      method_id == 1
    end
end

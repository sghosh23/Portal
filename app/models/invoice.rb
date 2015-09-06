class Invoice < ActiveRecord::Base
  attr_reader :userid, :invoice, :contact, :email, :invoice_data, :invoices
  def initialize
    client_d = Client.new
    @client = client_d.client
  end

  def get_all_invoices(user_id)
    response = @client.call(:get_all_invoices_for_user, message: { user_id: user_id })
    if response.success?
      @invoices = response.to_array(:get_all_invoices_for_user_response, :return)
    end
  end

  def get_contact(user_id)
    contact_res = @client.call(:get_user_contacts_ws, message: { user_id: user_id })
    if contact_res.success?
      data = contact_res.to_array(:get_user_contacts_ws_response,:return).first
      @contact = data
    end
  end

  def get_invoice(id)
    invoice_data = @client.call(:get_invoice_ws, message: { invoice_id: id})
    if invoice_data.success?
      data = invoice_data.to_array(:get_invoice_ws_response, :return).first
      @invoice_data = data
    end
  end
end

class Credit
  include ActiveModel::Model
  attr_accessor :amount, :card_name, :card_number, :month, :year, :method_id, :security
  validates_presence_of :amount, numericality: true
  validates_presence_of :card_name
  validates_presence_of :card_number, numericality: true
  validates_presence_of :month
  validates_presence_of :year
  validates_presence_of :security, numericality: true

  def process_payment(payment, invoice_id = {})
    response = @client.call(:apply_payment, message: { payment: payment, invoice_id: invoice_id })
    if response.success?
      data = response.to_array(:apply_payment_response, :return).first
    end
  end
end

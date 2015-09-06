class Order
  def initialize
    client_d = Client.new
    @client = client_d.client
  end

  def latest_order(user_id)
    response = @client.call(:get_latest_order, message: { user_id: user_id})
    if response.success?
      data = response.to_array(:get_latest_order_response, :retun).first
    end
  end

end

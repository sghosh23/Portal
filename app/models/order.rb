class Order
  def initialize
    client_d = Client.new
    @client = client_d.client
  end

  def latest_order(user_id)
    response = @client.call(:get_user_subscriptions, message: { user_id: user_id})
    if response.success?
      #data = response.to_array(:get_latest_order_response, :retun).first
      data = response.to_hash[:get_user_subscriptions_response][:return]
    end
  end

end

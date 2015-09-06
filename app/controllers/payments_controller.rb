class PaymentsController < ApplicationController
  before_action :logged_in_user, only:[:index, :show]
  def index
    @payment = Payment.new.get_latest_payment(current_user[:user_id])

  end
  def show

  end

end

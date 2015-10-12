class PaymentsController < ApplicationController
  before_action :logged_in_user, only:[:index, :show, :new]
  #include InvoiceFiltering
  def index
    @payment = Payment.new.get_latest_payment(current_user[:user_id])

  end

  def statement
    @payment_id = params[:id]
    @statement = Payment.new.get_payment(@payment_id)
    puts @payment_id
  end

  def show

    @statement = Payment.new.get_payment(params[:id])
  
  end

end

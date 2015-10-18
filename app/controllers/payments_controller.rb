class PaymentsController < ApplicationController
  before_action :logged_in_user, only:[:index, :show, :new]
  #include InvoiceFiltering
  def index

    #Rails.cache.fetch("#{session[:user_id]}/all_payments", expires_in: 12.hours) do
      @all_payments = Payment.new.get_all_payment(current_user[:user_id])
      @payments = []

      @all_payments.each do |payment|
        @payments << Payment.new.get_payment(payment.to_i)
      end
    #end
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

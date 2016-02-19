class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home, :account]
  #before_action :user_id, only: [:account]
  include InvoiceFiltering
  include InvoicesHelper
  def home
    if logged_in?
      user = User.new

      @user = user.get_user(session[:user_id])
      @latest_invoice = user.get_latest_invoice(session[:user_id])
      latest_time = create_time(@latest_invoice[:create_time_stamp]) if @latest_time
      @credit_data = user.previous_due(session[:user_id], latest_time)

      @payment_latest = Payment.new.get_latest_payment(current_user[:user_id])
      @order = Order.new.latest_order(current_user[:user_id])
      @order_type = @order.class
      #@latest_order = @order[:order_lines] if @order
      @payments = Payment.new.get_payment_by_date(current_user[:user_id])
      @payments_data = []
      @payments_data = @payments.map{|m| [ time_format(Date.strptime(m.split('@').last)), m.split('@').first.to_i]}
      @payment_list = @payments_data.sort{ |a, b| b[1] <=> a[1] }
      @payment = Payment.new

      @invoices_data = invoices.map { |e| [time_format(e[:create_time_stamp]), e[:id]] }
      @invoice_list = @invoices_data.sort{ |a, b| b[1] <=> a[1]}


    end
  end


  def account
    user = User.new
    @user = user.contact

    @userdata = user.get_user
  end


end

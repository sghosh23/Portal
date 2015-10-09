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
      #@items = @latest_invoice[:invoice_lines].reject { |h| h[:item_id] == "200" }
      @payment_latest = Payment.new.get_latest_payment(current_user[:user_id])
      @order = Order.new.latest_order(current_user[:user_id])
      @latest_order = @order[:order_lines] if @order
      @payments = Payment.new.get_payment_by_date(current_user[:user_id])
      @payments_data = []
      @payments_data = @payments.map{|m| [m.split('@').last, m.split('@').first.to_i]}
      @payment_list = @payments_data.sort{ |a, b| b[1] <=> a[1] }
      @payment = Payment.new

      @invoices_data = invoices.map { |e| [time_format(e[:create_time_stamp]), e[:id]] }
      @invoice_list = @invoices_data.sort{ |a, b| b[1] <=> a[1]}

      #puts current_user[:user_id]
      #puts @payments_data
    end
  end

  def help
  end

  def about

  end
  def account
    user = User.new
    @user = user.contact

    @userdata = user.get_user
  end


  # private
  #   def user_id
  #     user = User.new("splace")
  #
  #   end
end

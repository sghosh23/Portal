class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home, :account]
  #before_action :user_id, only: [:account]

  def home
    if logged_in?
      user = User.new

      @user = user.get_user(session[:user_id])
      @latest_invoice = user.get_latest_invoice(session[:user_id])
      @items = @latest_invoice[:invoice_lines].reject { |h| h[:item_id] == "200" }
      @payment = Payment.new.get_latest_payment(current_user[:user_id])
      @order = Order.new.latest_order(current_user[:user_id])
      puts "order"
      puts @order
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

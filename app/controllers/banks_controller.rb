class BanksController < ApplicationController
  include InvoiceFiltering
  def new
    @bank = Bank.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
    @bank = Bank.new(params[:ach])
    if @bank.valid?
      @payment_data =  @bank
      flash[:notice] = "Payment is success"
    else
      render :new
    end
  end
end

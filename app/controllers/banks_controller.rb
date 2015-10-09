class BanksController < ApplicationController
  include InvoiceFiltering
  def new
    @bank = Bank.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
    @bank = Bank.new(params[:ach])
    if @bank.valid?
      flash[:notice] = "Payment is success"
      redirect_to root_url
    else
      render :new
    end
  end
end

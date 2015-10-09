class CreditsController < ApplicationController
  include InvoiceFiltering
  def new
    @credit = Credit.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
    @credit = Credit.new(params[:credit])
    if @credit.valid?
      @payment_data =  @credit
      flash[:notice] = "Payment is success"
    else
      render :new
    end
  end
end

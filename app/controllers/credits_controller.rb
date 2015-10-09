class CreditsController < ApplicationController
  include InvoiceFiltering
  def new
    @credit = Credit.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
    @credit = Credit.new(params[:credit])
    if @credit.valid?
     flash.now[:info] = "Payment is success"
     redirect_to root_url
    else
      render :new
    end
  end
end

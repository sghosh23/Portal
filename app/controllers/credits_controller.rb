class CreditsController < ApplicationController
  include InvoiceFiltering
  def new
    @credit = Credit.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
    @credit = Credit.new(params[:credit])
    if @credit.valid?
      @invoice_id = params[:id]
      @today = Date.today
      @expiration = @credit.year.to_s + "-" + @credit.month.to_s
      payment_with_invoice = {:user_id => session[:user_id],
                 :amount => @credit.amount,
                 :amount_as_decimal => @credit.amount.to_f,
                 :is_refund => 0,
                 :method_id =>1,
                 :payment_date => @today,
                 :currency_id => 1,
                 :is_deposit => 0,
                 :invoice_ids => @invoice_id,
                 :credit_card => {
                 :deleted => 0,
                 :expiry => @expiration,
                 :name => @credit.card_name,
                 :number => @credit.card_number.to_i,
                 :security_code => @credit.security }
               }
       payment_without_invoice = {:user_id => session[:user_id],
                  :amount => @credit.amount,
                  :amount_as_decimal => @credit.amount.to_f,
                  :is_refund => 0,
                  :method_id =>1,
                  :payment_date => @today,
                  :currency_id => 1,
                  :is_deposit => 0,

                  :credit_card => {
                  :deleted => 0,
                  :expiry => @expiration,
                  :name => @credit.card_name,
                  :number => @credit.card_number.to_i,
                  :security_code => @credit.security }
                }
        if @invoice_id
           @data = Payment.new.process_payment(payment_with_invoice)
           if @data
             flash[:info] = "Payment is successfull by Credit card. Thank you for your payment."
             redirect_to payment_path(@data[:payment_id])

           end
        else
          @data = Payment.new.process_payment(payment_without_invoice)
          if @data
             flash[:info] = "Payment is successfull by Credit card. Thank you for your payment."
             redirect_to payment_path(@data[:payment_id])

          end
        end
      #flash.now[:info] = "Payment is successfull by Credit card. Thank you for your payment."
    else
      render :new
    end
  end
end

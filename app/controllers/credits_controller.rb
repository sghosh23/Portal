class CreditsController < ApplicationController
  include InvoiceFiltering
  def new
    @credit = Credit.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
     @credit = Credit.new(params[:credit])
    # @credit = Credit.new(credit_params)
    if @credit.valid?
      # @credit.save
      @invoice_id = params[:id]
      @today = Time.zone.today
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
             if @data[:response_message] == "Transaction failed"
               flash[:danger] = "Payment is failed. Please check your Acount information is correct."
             else
               flash[:success] = "Payment is successfull. Thank you for your payment. "
             end
             redirect_to payment_path(@data[:payment_id])

           end
        else
          @data = Payment.new.process_payment(payment_without_invoice)
          if @data
            if @data[:response_message] == "Transaction failed"
              flash[:danger] = "Payment is failed. Please check your Acount information is correct."

            else
              flash[:success] = "Payment is successfull. Thank you for your payment. "
            end
             redirect_to payment_path(@data[:payment_id])

          end
        end
      else
        render :new
      end
  end
  private
  def credit_params
    params.require(:credit).
    permit(:amount, :card_name, :card_number, :month, :year, :security).
    merge(user_id: session[:user_id])
  end
end

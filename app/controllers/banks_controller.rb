class BanksController < ApplicationController
  include InvoiceFiltering
  def new
    @bank = Bank.new
    @unpaid_invoices = unpaid_invoices
  end
  def create
    @bank = Bank.new(params[:bank])
    if @bank.valid?
      @invoice_id = params[:id]
      @today = Date.today

      payment_with_invoice = {:user_id => session[:user_id],
                 :amount => @bank.amount,
                 :amount_as_decimal => @bank.amount.to_f,
                 :is_refund => 0,
                 :method_id =>2,
                 :payment_date => @today,
                 :currency_id => 1,
                 :is_deposit => 0,
                 :invoice_ids => @invoice_id,
                 :ach => {
                 :aba_routing => @bank.routing_number,
                 :account_name => @bank.account_name,

                 :bank_account => @bank.account_number,
                 :bank_name => @bank.bank_name }
               }
      payment_without_invoice = {:user_id => session[:user_id],
                :amount => @bank.amount,
                :amount_as_decimal => @bank.amount.to_f,
                :is_refund => 0,
                :method_id =>2,
                :payment_date => @today,
                :currency_id => 1,
                :is_deposit => 0,

                :ach => {
                :aba_routing => @bank.routing_number,
                :account_name => @bank.account_name,
                :account_type => @bank.account_type.to_s,
                :bank_account => @bank.account_number,
                :bank_name => @bank.bank_name }
              }
       if @invoice_id
          @data = Payment.new.process_payment(payment_with_invoice)
          if @data
            flash.now[:info] = "Payment is success"
            redirect_to payment_path(@data[:payment_id])
          else
            @data = Payment.new.process_payment(payment)
          end
       else
         @data = Payment.new.process_payment(payment_without_invoice)
         if @data
            flash.now[:info] = "Payment is success"
            redirect_to payment_path(@data[:payment_id])
         else
            @data = Payment.new.process_payment(payment)
         end
       end

    else
      render :new
    end
  end
end
class InvoicesController < ApplicationController
  before_action :logged_in_user, only:[:index, :show]
  before_action :user_data, only: [:show, :create_invoice]
  #before_action :all_invoices, only: [:index, :show]
  include InvoiceFiltering
  
  def index
    @invoices = invoices
  end

  def show
   invoice = Invoice.new
   @invoice = invoice.get_invoice(params[:id])

   @items = @invoice[:invoice_lines].reject { |h| h[:item_id] == "200"}
   @tax = @invoice[:invoice_lines].select { |h| h[:item_id] == "200"}

   respond_to do |format|
     format.html
     format.pdf do
       render pdf: "invoice", layout: 'pdf.html',
              show_as_html: params[:debug].present?,
              no_pdf_compression:true,
              :margin => {:top => 0,
                          :bottom => 0,
                          :left => 0,
                          :right => 0}
     end
   end
 end

 def create_invoice
   @invoice = Invoice.new.get_invoice(params[:id])

   @items = @invoice[:invoice_lines].reject { |h| h[:item_id] == "200"}
   @tax = @invoice[:invoice_lines].select { |h| h[:item_id] == "200"}

   respond_to do |format|
     format.html
     format.pdf do
       render pdf: "invoice", layout: 'pdf.html',
              show_as_html: params[:debug].present?,
              no_pdf_compression:true,
              :margin => {:top => 0,
                          :bottom => 0,
                          :left => 0,
                          :right => 0}
     end
   end
 end

   private
     def user_data
       contact = Invoice.new
       @user = contact.get_contact(current_user[:user_id])
     end
     def all_invoices
       invoice = Invoice.new
       invoices = invoice.get_all_invoices(current_user[:user_id])
       invoices = invoices.reject { |h| h[:deleted].to_i == 1 }
       @invoices = invoices.sort_by{|h| h[:id]}.reverse
     end
end

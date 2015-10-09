module InvoiceFiltering
  extend ActiveSupport::Concern

  included do
    attr_reader :invoices, :unpaid_invoices
    before_filter :build_invoices, :build_unpaid_invoices
  end

  def build_invoices
    invoices = Invoice.new.get_all_invoices(current_user[:user_id])
    invoices = invoices.reject { |h| h[:deleted].to_i == 1 }
    @invoices = invoices.sort_by{|h| h[:id]}.reverse
  end
  def build_unpaid_invoices
    @unpaid_invoices = @invoices.select { |e| e[:status_id].to_i == 2  }
  end
end

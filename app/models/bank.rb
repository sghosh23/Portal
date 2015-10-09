class Bank
  include ActiveModel::Model
  attr_accessor :routing_number, :account_number, :bank_name, :account_name, :account_type, :amount, :method_id
  validates_presence_of :amount, numericality: true
  validates_presence_of :account_number
  validates_presence_of :bank_name
  validates_presence_of :account_name
  validates_presence_of :account_type
end

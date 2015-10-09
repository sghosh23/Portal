class Credit
  include ActiveModel::Model
  attr_accessor :amount, :card_name, :card_number, :month, :year, :method_id
  validates_presence_of :amount, numericality: true
  validates_presence_of :card_name
  validates_presence_of :card_number
  validates_presence_of :month
  validates_presence_of :year
end

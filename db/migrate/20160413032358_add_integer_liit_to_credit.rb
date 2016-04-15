class AddIntegerLiitToCredit < ActiveRecord::Migration
  def change
    change_column :credits, :card_number, :integer, limit: 8
  end
end

class AddAmountRequestedToCases < ActiveRecord::Migration
  def change
    add_column :cases, :amount_requested, :float
  end
end

class AddAmountApprovedToCases < ActiveRecord::Migration
  def change
    add_column :cases, :amount_approved, :float
  end
end

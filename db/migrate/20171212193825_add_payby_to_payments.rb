class AddPaybyToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :pay_by, :string
  end
end

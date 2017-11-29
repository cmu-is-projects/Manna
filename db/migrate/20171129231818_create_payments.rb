class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :payment_type
      t.string :payable_to
      t.integer :amount

      t.timestamps null: false
    end
  end
end

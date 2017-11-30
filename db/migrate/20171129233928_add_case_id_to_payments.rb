class AddCaseIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :case_id, :integer
  end
end

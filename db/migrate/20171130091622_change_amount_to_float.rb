class ChangeAmountToFloat < ActiveRecord::Migration
    def change
        change_column :payments, :amount, :float
    end
end

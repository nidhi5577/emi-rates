class CreateEmiRates < ActiveRecord::Migration[5.1]
  def change
    create_table :emi_rates do |t|
      t.string :lender
      t.integer :tenure
      t.integer :rate
      t.integer :minimum

      t.timestamps
    end
  end
end

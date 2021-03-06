class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.string :purchaser_name
      t.integer :purchase_count
      t.integer :item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end

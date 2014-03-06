class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :description
      t.float :price
      t.integer :merchant_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.datetime :date, :null => false
      t.string :title
      t.string :company
      t.string :location
      t.string :site
      t.integer :feed_id, :null => false
      t.text :apply
      t.text :content
      t.string :digest, :null => false
      t.string :url, :null => false
      t.timestamps
    end

    add_index :leads, :feed_id
    add_index :leads, :digest, :unique => true
    add_index :leads, :url, :unique => true
  end
end

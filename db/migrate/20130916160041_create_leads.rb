class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.datetime :date, :null => false
      t.string :title
      t.string :url, :null => false
      t.integer :feed_id, :null => false
      t.string :geo
      t.string :site
      t.text :content
      t.string :digest, :null => false

      t.timestamps
    end

    add_index :leads, :feed_id
    add_index :leads, :digest, :unique => true
  end
end

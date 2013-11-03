class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
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
      t.boolean :publish, :default => false
      t.timestamps
    end

    add_index :jobs, :feed_id
    add_index :jobs, :digest, :unique => true
    add_index :jobs, :url, :unique => true
  end
end

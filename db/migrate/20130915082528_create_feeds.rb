class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.boolean :active, :default => false
      t.string :name
      t.string :url
      t.text :fetch
      t.text :list
      t.boolean :newer, :default => true
      t.boolean :rss, :default => true
      t.integer :count, :default => 0

      t.timestamps
    end

    add_index :feeds, :url, :unique => true
  end
end

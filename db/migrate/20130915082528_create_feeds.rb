class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.boolean :active, :default => false
      t.string :name
      t.string :url
      t.text :hook
      t.text :list
      t.boolean :newer, :default => true
      t.boolean :rss, :default => true
      t.integer :view_count, :default => 0

      t.timestamps
    end

    add_index :feeds, :url, :unique => true
  end
end

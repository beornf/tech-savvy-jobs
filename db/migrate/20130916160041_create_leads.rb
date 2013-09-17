class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.integer :feed_id, :null => false
      t.string :title
      t.string :link
      t.string :source
      t.datetime :posted_at, :null => false
      t.string :job_hash, :null => false

      t.timestamps
    end

    add_index :leads, :job_hash, :unique => true
  end
end

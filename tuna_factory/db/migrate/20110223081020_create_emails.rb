class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.text :fulltext
      t.text :mail_object
      t.text :from
      t.text :to
      t.text :domain
      t.text :path
      t.text :gmail_path
      t.text :received
      t.integer :distance
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end

class CreateFingerprintMatches < ActiveRecord::Migration
  def self.up
    create_table :fingerprint_matches do |t|
      t.timestamps
      t.integer :email_id
      t.integer :fingerprint_id
    end
  end

  def self.down
    drop_table :fingerprint_matches
  end
end

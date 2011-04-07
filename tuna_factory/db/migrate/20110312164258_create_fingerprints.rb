class CreateFingerprints < ActiveRecord::Migration
  def self.up
    create_table :fingerprints do |t|
      t.string   :regex
      t.text	 :description
      t.integer  :confidence
      t.text 	 :references
      t.boolean	 :case
      t.timestamps
    end
  end

  def self.down
    drop_table :fingerprints
  end
end

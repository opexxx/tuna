# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110407062938) do

  create_table "emails", :force => true do |t|
    t.text     "fulltext"
    t.text     "mail_object"
    t.text     "from"
    t.text     "to"
    t.text     "domain"
    t.text     "path"
    t.text     "gmail_path"
    t.text     "received"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fingerprint_matches", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "email_id"
    t.integer  "fingerprint_id"
  end

  create_table "fingerprints", :force => true do |t|
    t.string   "name"
    t.string   "regex"
    t.text     "description"
    t.integer  "confidence"
    t.integer  "severity"
    t.text     "references"
    t.boolean  "case_sensitive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

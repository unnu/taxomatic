# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130123213948) do

  create_table "clients", :force => true do |t|
    t.string  "name",              :limit => 45
    t.boolean "is_active"
    t.integer "harvest_client_id"
  end

  create_table "expense_categories", :force => true do |t|
    t.string  "name",           :limit => 100, :default => "", :null => false
    t.integer "default_tax",    :limit => 2,   :default => 0,  :null => false
    t.integer "default_amount", :limit => 2,   :default => 0,  :null => false
    t.string  "note",                          :default => "", :null => false
    t.boolean "amortization"
  end

  add_index "expense_categories", ["name"], :name => "name_unique", :unique => true

  create_table "payments", :force => true do |t|
    t.integer   "amount_net",          :limit => 3
    t.integer   "tax",                 :limit => 1
    t.timestamp "updated_at",                                         :null => false
    t.date      "billed_on"
    t.string    "description"
    t.string    "ref_nr",              :limit => 100
    t.integer   "amount_gross",        :limit => 3
    t.integer   "expense_category_id", :limit => 2
    t.timestamp "created_at",                                         :null => false
    t.string    "type",                :limit => 45,  :default => "", :null => false
    t.integer   "client_id",           :limit => 2
    t.date      "paid_on"
    t.integer   "canceled",            :limit => 1,   :default => 0,  :null => false
    t.integer   "tax_declaration_id"
    t.string    "outbank_unique_id"
  end

  add_index "payments", ["ref_nr"], :name => "ref_nr unique", :unique => true

end

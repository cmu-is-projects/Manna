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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171130041939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "name"
    t.string   "doc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "case_attachments", force: :cascade do |t|
    t.integer  "case_id"
    t.integer  "attachment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cases", force: :cascade do |t|
    t.string   "client_name"
    t.string   "client_first_name"
    t.date     "date_submitted"
    t.string   "summary"
    t.text     "notes"
    t.text     "recommendation"
    t.string   "status"
    t.integer  "deacon_id"
    t.string   "subject"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.float    "amount_requested"
    t.float    "amount_approved"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "payment_type"
    t.string   "payable_to"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "case_id"
    t.string   "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "role"
    t.boolean  "active",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "deacon_id"
    t.string   "decision"
    t.integer  "case_id"
    t.date     "date_submitted"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end

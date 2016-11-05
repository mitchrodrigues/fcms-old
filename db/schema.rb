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

ActiveRecord::Schema.define(version: 20160807030905) do

  create_table "address_relations", force: :cascade do |t|
    t.integer "owner_id",   limit: 4
    t.string  "owner_type", limit: 255
    t.integer "address_id", limit: 4
    t.boolean "primary"
    t.date    "started_at"
    t.date    "ended_at"
  end

  add_index "address_relations", ["address_id"], name: "index_address_relations_on_address_id", using: :btree
  add_index "address_relations", ["owner_id", "owner_type"], name: "index_address_relations_on_owner_id_and_owner_type", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "street1",     limit: 255
    t.string   "street2",     limit: 255
    t.string   "city",        limit: 255
    t.string   "postal_code", limit: 255
    t.string   "state",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.string  "type",            limit: 255, null: false
    t.integer "owner_id",        limit: 4,   null: false
    t.string  "owner_type",      limit: 255, null: false
    t.integer "resource_id",     limit: 4,   null: false
    t.string  "resource_type",   limit: 255, null: false
    t.integer "organization_id", limit: 4
    t.date    "started_at"
    t.date    "ended_at"
  end

  add_index "assignments", ["organization_id"], name: "index_assignments_on_organization_id", using: :btree
  add_index "assignments", ["owner_id", "owner_type", "resource_id", "resource_type"], name: "owner_resource_idx", using: :btree
  add_index "assignments", ["resource_id", "resource_type", "owner_id", "owner_type"], name: "resource_owner_idx", using: :btree
  add_index "assignments", ["started_at", "ended_at"], name: "index_assignments_on_started_at_and_ended_at", using: :btree
  add_index "assignments", ["type"], name: "index_assignments_on_type", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "office_id",       limit: 4
    t.integer  "organization_id", limit: 4
    t.integer  "bed_count",       limit: 4,   default: 0
    t.boolean  "active",                      default: true
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "facilities", ["office_id", "active", "organization_id"], name: "office_org_act_idx", using: :btree
  add_index "facilities", ["office_id"], name: "index_facilities_on_office_id", using: :btree
  add_index "facilities", ["organization_id"], name: "index_facilities_on_organization_id", using: :btree

  create_table "offices", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "organization_id", limit: 4
    t.boolean  "primary",                     default: false
    t.boolean  "active",                      default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "offices", ["organization_id"], name: "index_offices_on_organization_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                 default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "type",            limit: 30
    t.string   "first_name",      limit: 30
    t.string   "middle_name",     limit: 30
    t.string   "last_name",       limit: 30
    t.date     "dob"
    t.string   "social",          limit: 255
    t.integer  "organization_id", limit: 4
    t.string   "email",           limit: 255
    t.string   "password",        limit: 255
    t.string   "salt",            limit: 32
    t.boolean  "staff",                       default: false
    t.boolean  "active",                      default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "people", ["email", "password"], name: "index_people_on_email_and_password", using: :btree
  add_index "people", ["organization_id"], name: "index_people_on_organization_id", using: :btree
  add_index "people", ["type", "organization_id"], name: "index_people_on_type_and_organization_id", using: :btree
  add_index "people", ["type"], name: "index_people_on_type", using: :btree

end

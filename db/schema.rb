# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_06_175928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ambassadors", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "social_profile_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_categories_on_topic_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name"
    t.string "description"
    t.string "website_url"
    t.string "video_url"
    t.string "video_alt_text"
    t.string "video_source"
    t.bigint "ambassador_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ambassador_id"], name: "index_institutions_on_ambassador_id"
    t.index ["country_id"], name: "index_institutions_on_country_id"
  end

  create_table "policies", force: :cascade do |t|
    t.bigint "policy_making_id", null: false
    t.bigint "category_id", null: false
    t.string "name"
    t.string "content"
    t.string "policy_plan"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_policies_on_category_id"
    t.index ["policy_making_id"], name: "index_policies_on_policy_making_id"
  end

  create_table "policy_making_institutions", force: :cascade do |t|
    t.bigint "policy_making_id", null: false
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_policy_making_institutions_on_institution_id"
    t.index ["policy_making_id"], name: "index_policy_making_institutions_on_policy_making_id"
  end

  create_table "policy_makings", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.bigint "topic_id", null: false
    t.string "content"
    t.string "video_url"
    t.string "video_alt_text"
    t.string "video_source"
    t.bigint "ambassador_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ambassador_id"], name: "index_policy_makings_on_ambassador_id"
    t.index ["country_id"], name: "index_policy_makings_on_country_id"
    t.index ["topic_id"], name: "index_policy_makings_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_policy_makings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "policy_making_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_making_id"], name: "index_user_policy_makings_on_policy_making_id"
    t.index ["user_id"], name: "index_user_policy_makings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "topics"
  add_foreign_key "institutions", "ambassadors"
  add_foreign_key "institutions", "countries"
  add_foreign_key "policies", "categories"
  add_foreign_key "policies", "policy_makings"
  add_foreign_key "policy_making_institutions", "institutions"
  add_foreign_key "policy_making_institutions", "policy_makings"
  add_foreign_key "policy_makings", "ambassadors"
  add_foreign_key "policy_makings", "countries"
  add_foreign_key "policy_makings", "topics"
  add_foreign_key "user_policy_makings", "policy_makings"
  add_foreign_key "user_policy_makings", "users"
end

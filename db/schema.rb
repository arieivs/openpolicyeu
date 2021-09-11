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

ActiveRecord::Schema.define(version: 2021_09_11_132929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ambassadors", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "social_profile_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "answer"
    t.string "explanation"
    t.boolean "right"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
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

  create_table "game_answers", force: :cascade do |t|
    t.string "answer"
    t.string "explanation"
    t.boolean "right"
    t.bigint "game_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_question_id"], name: "index_game_answers_on_game_question_id"
  end

  create_table "game_questions", force: :cascade do |t|
    t.integer "order"
    t.string "name"
    t.string "context"
    t.string "question"
    t.bigint "policy_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_plan_id"], name: "index_game_questions_on_policy_plan_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "order"
    t.bigint "policy_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_plan_id"], name: "index_goals_on_policy_plan_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name"
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
    t.string "description"
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

  create_table "policy_plan_institutions", force: :cascade do |t|
    t.bigint "policy_plan_id", null: false
    t.bigint "institution_id", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_policy_plan_institutions_on_institution_id"
    t.index ["policy_plan_id"], name: "index_policy_plan_institutions_on_policy_plan_id"
  end

  create_table "policy_plans", force: :cascade do |t|
    t.string "name"
    t.string "content"
    t.string "video_url"
    t.string "video_alt_text"
    t.string "video_source"
    t.boolean "strategy"
    t.bigint "policy_making_id", null: false
    t.bigint "ambassador_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "short_description"
    t.index ["ambassador_id"], name: "index_policy_plans_on_ambassador_id"
    t.index ["policy_making_id"], name: "index_policy_plans_on_policy_making_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "policy_making_id", null: false
    t.string "scope"
    t.string "question"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_making_id"], name: "index_questions_on_policy_making_id"
  end

  create_table "timesteps", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.string "description"
    t.bigint "policy_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_plan_id"], name: "index_timesteps_on_policy_plan_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "icon"
    t.string "icon_color"
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

  create_table "volunteers", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "linkedin_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "young_contributors", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "website_url"
    t.bigint "policy_plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["policy_plan_id"], name: "index_young_contributors_on_policy_plan_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "categories", "topics"
  add_foreign_key "game_answers", "game_questions"
  add_foreign_key "game_questions", "policy_plans"
  add_foreign_key "goals", "policy_plans"
  add_foreign_key "institutions", "ambassadors"
  add_foreign_key "institutions", "countries"
  add_foreign_key "policies", "categories"
  add_foreign_key "policies", "policy_makings"
  add_foreign_key "policy_making_institutions", "institutions"
  add_foreign_key "policy_making_institutions", "policy_makings"
  add_foreign_key "policy_makings", "ambassadors"
  add_foreign_key "policy_makings", "countries"
  add_foreign_key "policy_makings", "topics"
  add_foreign_key "policy_plan_institutions", "institutions"
  add_foreign_key "policy_plan_institutions", "policy_plans"
  add_foreign_key "policy_plans", "ambassadors"
  add_foreign_key "policy_plans", "policy_makings"
  add_foreign_key "questions", "policy_makings"
  add_foreign_key "timesteps", "policy_plans"
  add_foreign_key "user_policy_makings", "policy_makings"
  add_foreign_key "user_policy_makings", "users"
  add_foreign_key "young_contributors", "policy_plans"
end

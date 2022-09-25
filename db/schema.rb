ActiveRecord::Schema[7.0].define(version: 2022_09_25_222755) do
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "api_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

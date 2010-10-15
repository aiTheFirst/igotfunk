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

ActiveRecord::Schema.define(:version => 16) do

  create_table "rankings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "user_id"
    t.string   "description", :limit => 200
    t.boolean  "is_current"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_category_id"
    t.integer  "story_source_id"
    t.string   "name",              :limit => 200
    t.string   "url_slug",          :limit => 250
    t.string   "url",               :limit => 500
    t.string   "displayed_url",     :limit => 500
    t.string   "url_video_id"
    t.text     "description"
    t.integer  "comment_count",                    :default => 0
    t.integer  "funks",                            :default => 0
    t.integer  "views",                            :default => 0
    t.integer  "funk_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_source_filters", :force => true do |t|
    t.integer  "story_source_id"
    t.string   "pre_regex"
    t.string   "post_regex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_source_id_filters", :force => true do |t|
    t.integer  "story_source_id"
    t.integer  "priority",        :default => 0
    t.string   "pre_id_regex"
    t.string   "post_id_regex",   :default => "&"
    t.string   "pre_id_url"
    t.string   "post_id_url",     :default => "&"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_sources", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.text     "video_player_code"
    t.integer  "parent_id",         :default => -1
    t.boolean  "is_redirected",     :default => false
    t.string   "video_link"
    t.string   "icon_filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail_link"
  end

  create_table "story_tag_links", :force => true do |t|
    t.integer  "story_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 200
    t.integer  "parent_id",                 :default => -1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "location"
    t.string   "website"
    t.integer  "views",      :default => 0
    t.string   "gender"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", :force => true do |t|
    t.string   "key"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "user_type_id"
  end

end

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

ActiveRecord::Schema[7.2].define(version: 2025_02_28_151656) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_bookmarks_on_tweet_id"
    t.index ["user_id", "tweet_id"], name: "index_bookmarks_on_user_id_and_tweet_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "followings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "following_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id"], name: "index_followings_on_following_user_id"
    t.index ["user_id", "following_user_id"], name: "index_followings_on_user_id_and_following_user_id", unique: true
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "hashtags", force: :cascade do |t|
    t.string "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag"], name: "index_hashtags_on_tag"
  end

  create_table "hashtags_tweets", id: false, force: :cascade do |t|
    t.bigint "hashtag_id"
    t.bigint "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashtag_id"], name: "index_hashtags_tweets_on_hashtag_id"
    t.index ["tweet_id"], name: "index_hashtags_tweets_on_tweet_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "tweet_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_likes_on_tweet_id"
    t.index ["user_id", "tweet_id"], name: "index_likes_on_user_id_and_tweet_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "mentions", force: :cascade do |t|
    t.bigint "tweet_id", null: false
    t.bigint "mentioned_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentioned_user_id"], name: "index_mentions_on_mentioned_user_id"
    t.index ["tweet_id"], name: "index_mentions_on_tweet_id"
  end

  create_table "message_threads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_threads_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "message_thread_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_thread_id"], name: "index_message_threads_users_on_message_thread_id"
    t.index ["user_id"], name: "index_message_threads_users_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "message_thread_id", null: false
    t.index ["message_thread_id"], name: "index_messages_on_message_thread_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "actor_id", null: false
    t.bigint "tweet_id"
    t.string "verb", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_notifications_on_actor_id"
    t.index ["tweet_id"], name: "index_notifications_on_tweet_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "retweets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_retweets_on_tweet_id"
    t.index ["user_id", "tweet_id"], name: "index_retweets_on_user_id_and_tweet_id", unique: true
    t.index ["user_id"], name: "index_retweets_on_user_id"
  end

  create_table "tweet_activities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.string "verb", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "actor_id", null: false
    t.index ["actor_id"], name: "index_tweet_activities_on_actor_id"
    t.index ["tweet_id"], name: "index_tweet_activities_on_tweet_id"
    t.index ["user_id"], name: "index_tweet_activities_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "retweets_count", default: 0, null: false
    t.integer "views_count", default: 0, null: false
    t.bigint "parent_tweet_id"
    t.integer "reply_tweets_count", default: 0, null: false
    t.index ["parent_tweet_id"], name: "index_tweets_on_parent_tweet_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "display_name"
    t.text "bio"
    t.string "location"
    t.string "profile_url"
    t.integer "follower_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "views", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_views_on_tweet_id"
    t.index ["user_id", "tweet_id"], name: "index_views_on_user_id_and_tweet_id", unique: true
    t.index ["user_id"], name: "index_views_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "tweets"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "followings", "users"
  add_foreign_key "followings", "users", column: "following_user_id"
  add_foreign_key "likes", "tweets"
  add_foreign_key "likes", "users"
  add_foreign_key "mentions", "tweets"
  add_foreign_key "mentions", "users", column: "mentioned_user_id"
  add_foreign_key "messages", "message_threads"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "tweets"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "actor_id"
  add_foreign_key "retweets", "tweets"
  add_foreign_key "retweets", "users"
  add_foreign_key "tweet_activities", "tweets"
  add_foreign_key "tweet_activities", "users"
  add_foreign_key "tweet_activities", "users", column: "actor_id"
  add_foreign_key "tweets", "tweets", column: "parent_tweet_id"
  add_foreign_key "tweets", "users"
  add_foreign_key "views", "tweets"
  add_foreign_key "views", "users"
end

# t.string   "name"
# t.boolean  "public"
# t.integer  "user_id"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.string   "nan_file_name"
# t.string   "nan_content_type"
# t.integer  "nan_file_size"
# t.datetime "nan_updated_at"
# t.string   "message_id"

class Loop
  include MongoMapper::Document
  key :name
  key :public, Boolean
  key :message_id


  belongs_to :user
  
  
end
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

require 'tempfile'

class Loop
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Grid

  field :name
  field :public, :type => Boolean
  field :message_id
  field :plays_and_downloads, :type => Integer

  attachment :nan
  belongs_to_related :user

  def data=(data)
    unless data.blank?
      f = Tempfile.open("data")
      raw_data = Base64.decode64(data.gsub(/^nanoloop:\/\//,'').gsub(/\-/, '+').gsub(/_/,'/'))
      f.write(raw_data)
      puts f.size
      f.rewind
      self.nan = f
    end
  end

  def data
    return nil unless nan
    raw_data = nan.read
    "nanoloop://" + Base64.encode64(raw_data).gsub(/\+/, '-').gsub(/\//, '_').gsub(/\n/,'').gsub(/ /,'')
  end


end
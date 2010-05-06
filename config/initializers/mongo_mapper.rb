File.open(File.join(RAILS_ROOT, 'config/mongodb.yml'), 'r') do |f|
  @settings = YAML.load(f)[RAILS_ENV]
end
MongoMapper.connection = Mongo::Connection.from_uri(@settings["connection"]) if @settings["connection"]
MongoMapper.database = @settings["database"]
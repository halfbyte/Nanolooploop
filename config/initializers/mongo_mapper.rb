File.open(File.join(RAILS_ROOT, 'config/mongodb.yml'), 'r') do |f|
  @settings = YAML.load(f)[RAILS_ENV]
end
MongoMapper.database = @settings["database"]
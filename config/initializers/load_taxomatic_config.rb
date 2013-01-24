begin
  AppConfig = YAML.load_file(Rails.root.join('config/taxomatic.yml'))
rescue Errno::ENOENT => e
  AppConfig = {}
end
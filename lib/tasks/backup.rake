task :backup => ["backup:dump_db"]

namespace :backup do
  
  desc "Dump the current database state to a file"
  task :dump_db => :environment do
    filename = Time.now.strftime('taxomatic_backup_%d%m%Y_%H%M.sql')
    path     = Rails.root.join('data/backups', filename)
    config   = YAML.load_file(Rails.root.join('config/database.yml'))[Rails.env]
    `mysqldump -u#{config['username']} #{config['database']} > #{path}`
    if (File.read(path).size > 1024)
      puts "Dumped current database state to #{path}."
    else
      puts "Dumping to #{path} seems to have failed."
    end
  end
  
end
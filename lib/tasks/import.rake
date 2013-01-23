task :import => ["import:invoices", "import:statement"]

namespace :import do
  
  desc "Import invoices from Harvest."
  task :invoices => :environment do
    Harvest::InvoiceImport.run!(ENV['PASSWORD'])
  end
  
  desc "Import statement lines from an Outbank CSV file, the file is expected at data/outbank.csv."
  task :statement => :environment do
    Outbank::StatementImport.run!
  end
  
end
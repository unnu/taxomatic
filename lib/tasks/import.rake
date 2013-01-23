task :import => ["import:invoices", "import:statement"]

namespace :import do
  
  task :invoices => :environment do
    Harvest::InvoiceImport.run!(ENV['PASSWORD'])
  end
  
  task :statement => :environment do
    Outbank::StatementImport.run!
  end
  
end
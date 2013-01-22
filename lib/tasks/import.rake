task :import => "import:import_invoices"

namespace :import do
  
  task :import_invoices => :environment do
    Harvest::InvoiceImport.run!(ENV['PASSWORD'])
  end
  
end
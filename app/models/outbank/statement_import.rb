require 'csv'

module Outbank
  class StatementImport

    # required for testing only
    attr_reader :csv

    def self.run!(csv_file = 'data/outbank.csv')
      new(csv_file).run!
    end
  
    def initialize(csv_file)
      path = Rails.root.join(csv_file)
      options = { 
        :col_sep => ';', 
        :headers => true,
        :converters => [:all]
      }
      @csv = CSV.new(File.read(path), options)
    end
  
    def run!
      print_csv_info(@csv)
      imported_rows = 0
      @csv.each do |row|
        outbank_line = Outbank::StatementLine.new(row)
        line = ::StatementLine.find_by_outbank_unique_id(outbank_line.unique_id)
        unless line
          puts "importing #{outbank_line.to_s} ... "
          begin
            line = ::StatementLine.create_from_outbank_line!(outbank_line)
            imported_rows += 1
            puts "   done."
          rescue ActiveRecord::RecordInvalid => e
            puts "failed "
            puts "Error: #{e.message}"
            puts "Kategorie: #{outbank_line.category}"
            next
          end
        end
      end
      puts "Imported #{imported_rows} row(s)."
    end
    
    private
    
    def print_csv_info(csv)
      csv = csv.read
      earliest_booking = csv[csv.size - 1]['Buchungstag']
      latest_booking   = csv[0]['Buchungstag']
      puts "CSV has #{csv.size} statement lines from #{earliest_booking} to #{latest_booking}."
    end    
    
  end

end
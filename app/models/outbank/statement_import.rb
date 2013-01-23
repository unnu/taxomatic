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
      @csv.each do |row|
        outbank_line = Outbank::StatementLine.new(row)
        line = ::StatementLine.find_by_outbank_unique_id(outbank_line.unique_id)
        if line
          puts "Outbank statement line already imported."
        else
          puts "Importing outbank statement line ..."
          line = ::StatementLine.create_from_outbank_line!(outbank_line)
        end
      end
    end
    
  end

end
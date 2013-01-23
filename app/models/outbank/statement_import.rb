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
        line = Outbank::StatementLine.new(row)
        #unless StatementLine.exists?
        ::StatementLine.create_from_outbank_line!(line)
        #end
      end
    end
    
  end

end
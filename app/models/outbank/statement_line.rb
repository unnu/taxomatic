module Outbank
  
  class StatementLine

    include MoneyStringParser
    
    ATTRIBUTE_MAPPING = {
      :description2 => "Buchungstext",
      :currency => "Währung",
      :amount => "Betrag",
      :booked_on => "Buchungstag",
      :valuta_on => "Valuta-Datum",
      :recipient => "Empfänger/Auftraggeber",
      :bank_code => "Bankleitzahl",
      :account_number => "Kontonummer",
      :description => "Verwendungszweck"
    }

    def initialize(csv_row)
      @row = csv_row
    end
    
    def amount
      to_cents(@row['Betrag'])
    end
    
    def booked_on
      Date.parse(@row['Buchungstag'])
    end
    
    def valuta_on
      Date.parse(@row['Valuta-Datum'])
    end
    
    def description
      @row['Verwendungszweck'].gsub(/\s+/, ' ')
    end
    
    def method_missing(arg)
      @row.send(:[], ATTRIBUTE_MAPPING[arg])
    end
  end
end
class TaxController < ApplicationController

=begin

ABLAUF:

- zeitraum auswählen

- einnahmen errechnen
  - bemessungsgrundlage (summe netto)
  - vereinnahmte ust (summe ust)

- ausgaben raussuchen
  - bezahlung
  - abziehbare vorsteuer errechnen
  

zeige felder:
- 

=end

  # :TODO: 
  #
  # - "freeze" des übermittelten status
  #  - alle rel. daten kopieren
  #  - PreliminaryTaxAnnouncement -> has many items (); a creation_date, transfer date, elster file & pdf.
  # - bei der rechnung / ausgabe anzeigen, in welche erklärung sie eingegangen ist
  # - browsen der 
  # 
  # - nachträglich gefundene beträge oder korrekturen am jahresende einbaubar
  #
  #
  QUARTER_TO_MONTHS_MAPPING = { 1 => (1..3), 2 => (4..6), 3 => (7..9), 4 => (10..12) }
  def ust
    if params[:date]
      @quarter = params[:date][:quarter].to_i
      @year   = params[:date][:year].to_i
    else 
      @quarter = 1
      @year   = Time.now.year
    end
    @months = QUARTER_TO_MONTHS_MAPPING[@quarter]
    @invoices = Invoice.find_all_by_months(@months, @year)
    @expenses = Expense.find_all_by_months(@months, @year)

    @invoices_net_sum = sum_amount_net(@invoices)
    @invoices_ust_sum = sum_ust(@invoices)

    @expenses_net_sum = sum_amount_net(@expenses)
    @expenses_ust_sum = sum_ust(@expenses)
  end
  
  private
  
    def sum_amount_net(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.amount_net_euro.to_f) }
    end
    
    def sum_ust(invoices)
      invoices.inject(0) { |sum, i| sum = (sum + i.ust_euro.to_f) }
    end
  
end

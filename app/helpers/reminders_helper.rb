module RemindersHelper
  def unpaid_invoices_select
    invoices = Invoice.unpaid
    #invoices.unshift(Invoice.new(:id => 0, :description => '--- Bitte waehlen ---', :client => Client.new(:name => 'Foo')))
    invoices.map! { |inv| [inv.client.name + ' - ' + inv.description, inv.id]}
    select('reminder', 'invoice_id', invoices)
  end
end

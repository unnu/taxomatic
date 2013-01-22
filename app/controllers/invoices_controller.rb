class InvoicesController < ApplicationController

  before_filter :form_common, :except => [:index, :list, :show]
  
  def index
    params[:year] = Time.now.year unless params[:year]
    @invoices = Invoice.all_for_year(params[:year]).without_canceled
    respond_to do |wants|
      wants.html {}
      wants.xls do
        data     = invoices_for_excel(@invoices).to_xls
        filename = "invoices_#{params[:year]}.xls"
        send_data(data, :disposition => "attachment", :filename => filename)
      end
    end
    
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
  end

  def new_from_template
    @invoice = Invoice.find(params[:id])
    @invoice.id = nil
    render :action => 'new'
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    if @invoice.save
      flash[:notice] = 'Invoice was successfully created.'
      redirect_to invoices_path
    else
      render :action => 'new'
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      flash[:notice] = 'Invoice was successfully updated.'
      redirect_to invoices_path(:id => @invoice)
    else
      render :action => 'edit'
    end
  end

  def destroy
    Invoice.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  private
  
    def invoices_for_excel(invoices)
      invoices.map! do |i| 
        [i.ref_nr, i.paid_on, i.client.name, i.amount_net, i.amount_gross, i.description]
      end
      invoices.unshift(%w(Nummer Zahldatum Kunde Netto Brutto Beschreibung))
    end
  
    def form_common
      @clients = get_clients
    end

end

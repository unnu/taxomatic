class InvoicesController < ApplicationController

  before_filter :form_common, :except => [:index, :list, :show]
  
  def form_common
    @clients = get_clients
  end

  def index
    list
    render :action => 'list'
  end

  def list
    @invoices = Invoice.find(:all, :order => 'billed_on DESC', :include => :client)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    if params[:website_id].nil?
      @invoice = Invoice.new
    else
      @invoice = Invoice.new
      # jaja ugly, referenz nochmal reinpacken
      website = Website.find(params[:website_id])
      #@invoice.website = website
      @invoice.website_id = website.id
      @invoice.client  = Client.find(website.client.id)
      @invoice.tax = 16
      @invoice.amount_net = website.total_cost_per_year.to_i
      @invoice.amount_gross = (website.total_cost_per_year * (1 + UST)).to_i
      @invoice.description = 'Webhosting %02d.%d-%02d.%d' % 
        [ website.created_on.month, Time.new.year, (website.created_on.month % 12)-1, Time.new.year + 1]
    end
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
      redirect_to :action => 'list'
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
      redirect_to :action => 'list', :id => @invoice
    else
      render :action => 'edit'
    end
  end

  def destroy
    Invoice.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
end

class WebsitesController < ApplicationController

  before_filter :form_common, :except => [:index, :list, :show]
  
  def form_common
    # im format für die erzeugung eines select feld!
    @clients = get_clients
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    # alle kunden die min. eine website haben darstellen
    @clients = Client.active.select { |c| !c.websites.empty? } 
    # summe über alle sites aller kunden
    @yearly_hosting_income = @clients.inject(0) do |client_sum, client| 
      client_sum + client.websites.inject(0) { |sum, website| sum + website.total_cost_per_year }
    end
    @monthly_hosting_income = ((@yearly_hosting_income / 12) * 100).round / 100
  end

  def show
    @website = Website.find(params[:id])
    @total_cost_netto  = @website.domains.inject(0) { |sum, domain| sum += domain.cost_per_year }
    @total_cost_netto += @website.hosting_fee_per_year
    @total_cost_brutto = @total_cost_netto * (1 + UST)
  end

  def new
    @website = Website.new
  end

  def create
    @website = Website.new(params[:website])
    if @website.save
      flash[:notice] = 'Website was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @website = Website.find(params[:id])
  end

  def update
    @website = Website.find(params[:id])
    if @website.update_attributes(params[:website])
      flash[:notice] = 'Website was successfully updated.'
      redirect_to :action => 'list', :id => @website
    else
      render :action => 'edit'
    end
  end

  def destroy
    Website.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
end

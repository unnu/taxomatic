class DomainsController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @domain_pages, @domains = paginate :domains, :per_page => 10
  end

  def show
    @domain = Domain.find(params[:id])
  end

  def new
    begin
      @website = Website.find(params[:id])
      @domain = Domain.new(
        :name => @website.name,
        :website_id => params[:id]
      )
    rescue => e
      # do something useful here!
      raise e
    end
  end

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      flash[:notice] = 'Domain was successfully created.'
      redirect_to :controller => 'websites', :action => 'show', :id => @domain.website_id
    else
      render :action => 'new'
    end
  end

  def edit
    @domain = Domain.find(params[:id])
  end

  def update
    @domain = Domain.find(params[:id])
    if @domain.update_attributes(params[:domain])
      flash[:notice] = 'Domain was successfully updated.'
      redirect_to :action => 'show', :id => @domain
    else
      render :action => 'edit'
    end
  end

  def destroy
    Domain.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

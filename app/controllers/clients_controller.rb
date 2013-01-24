class ClientsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @clients = Client.order(:name)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new(:is_active => true)
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:notice] = 'Client was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:notice] = 'Client was successfully updated.'
      redirect_to :action => 'list', :id => @client
    else
      render :action => 'edit'
    end
  end

  def destroy
    Client.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

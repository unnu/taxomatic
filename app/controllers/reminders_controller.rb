class RemindersController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  def list
    @reminders = Reminder.all(:order => 'created_on DESC')
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(params[:reminder])
    if @reminder.save
      flash[:notice] = 'Reminder was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @reminder = Reminder.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])
    if @reminder.update_attributes(params[:reminder])
      flash[:notice] = 'Reminder was successfully updated.'
      redirect_to :action => 'show', :id => @reminder
    else
      render :action => 'edit'
    end
  end

  def destroy
    Reminder.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
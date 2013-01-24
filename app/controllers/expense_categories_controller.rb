class ExpenseCategoriesController < ApplicationController

  def index
    @expense_categories = ExpenseCategory.all(:order => 'name')
  end
  
  def show
    @expense_category = ExpenseCategory.find(params[:id])
  end

  def new
    @expense_category = ExpenseCategory.new
  end

  def create
    @expense_category = ExpenseCategory.new(params[:expense_category])
    if @expense_category.save
      flash[:notice] = 'ExpenseCategory was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @expense_category = ExpenseCategory.find(params[:id])
  end

  def update
    @expense_category = ExpenseCategory.find(params[:id])
    if @expense_category.update_attributes(params[:expense_category])
      flash[:notice] = 'ExpenseCategory was successfully updated.'
      redirect_to :action => 'index', :id => @expense_category
    else
      render :action => 'edit'
    end
  end

  def destroy
    ExpenseCategory.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end

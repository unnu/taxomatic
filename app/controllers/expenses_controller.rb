class ExpensesController < ApplicationController

  before_filter :form_common, :except => [:index, :list, :show]
  
  def form_common
    @expense_categories = get_expense_categories
    @expense_categories_taxes = get_expense_categories_taxes
  end

  def index
    @expenses = if (params[:year] == 'all')
      Expense.all(:order => 'billed_on DESC, created_at DESC', :include => :expense_category)
    else
      # ugleh hack
      params[:year] = Time.now.year unless params[:year]
      Expense.all_for_year(params[:year])
    end
    respond_to do |wants|
      wants.html {}
      wants.xls do
        data     = expenses_for_excel(@expenses).to_xls
        filename = "expenses_#{params[:year]}.xls"
        send_data(data, :disposition => "attachment", :filename => filename)
      end
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end
  
  def new_from_template
    @expense = Expense.find(params[:id])
    @expense.id = nil
    render :action => 'new'
  end

  def create
    @expense = Expense.new(params[:expense])
    if @expense.save
      flash[:notice] = 'Expense was successfully created.'
      redirect_to :action => 'new'
    else
      render :action => 'new'      
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(params[:expense])
      flash[:notice] = 'Expense was successfully updated.'
      flash[:highlight_row] = params[:id]
      redirect_to :action => 'list', :id => @expense
    else
      render :action => 'edit'
    end
  end

  def destroy
    Expense.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  private
  
    def get_expense_categories
      cats = ExpenseCategory.all(:order => 'name')
      cats.unshift(ExpenseCategory.new(:id => 0, :name => '--- Bitte waehlen ---'))
      cats.map { |cat| [cat.name, cat.id]}
    end
    
    def get_expense_categories_taxes
      cats = ExpenseCategory.all(:order => 'name')
      cats.map { |cat| [cat.id,  cat.default_tax]}
    end
    
    def get_interval_options
      [
        ['--- Bitte waehlen ---', nil],
        ['jaehrlich', 'y'],
        ['quartalsweise', 'q'],
        ['monatlich', 'm'],
        ['woechentlich', 'w']
      ]
    end
    
    def expenses_for_excel(expenses)
      expenses.map! do |e| 
        [e.billed_on, e.category.name, e.amount_net, e.amount_gross, e.description]
      end
      expenses.unshift(%w(Rechnungsdatum Kategorie Netto Brutto Bechreibung))
    end
end

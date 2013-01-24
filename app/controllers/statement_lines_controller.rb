class StatementLinesController < ApplicationController

  def index
    @statement_lines = StatementLine.debits.possible_expense.includes(:expense).order("billed_on DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statement_lines }
    end
  end

  # creates or deletes an expense for this statement_line
  # making it (in)visible in tax declarations 
  def update_expense
    line = StatementLine.find(params[:id])
    if params[:create_expense]
      line.create_expense!
    else
      line.destroy_expense!
    end
    respond_to do |format|
      format.json { render :json => {}, :status => 200 }
    end
  end
  
  # 
  # maybe useful later
  #
  #def show
  #  @statement_line = StatementLine.find(params[:id])
  #
  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @statement_line }
  #  end
  #end
  #
  #def update
  #  @statement_line = StatementLine.find(params[:id])
  #
  #  respond_to do |format|
  #    if @statement_line.update_attributes(params[:statement_line])
  #      format.html { redirect_to @statement_line, notice: 'Statement line was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @statement_line.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  #def edit
  #  @statement_line = StatementLine.find(params[:id])
  #end
  #
  #def destroy
  #  @statement_line = StatementLine.find(params[:id])
  #  @statement_line.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to statement_lines_url }
  #    format.json { head :no_content }
  #  end
  #end
  #
end

class StatementLinesController < ApplicationController
  # GET /statement_lines
  # GET /statement_lines.json
  def index
    @statement_lines = StatementLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statement_lines }
    end
  end

  # GET /statement_lines/1
  # GET /statement_lines/1.json
  def show
    @statement_line = StatementLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statement_line }
    end
  end

  # GET /statement_lines/new
  # GET /statement_lines/new.json
  def new
    @statement_line = StatementLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statement_line }
    end
  end

  # GET /statement_lines/1/edit
  def edit
    @statement_line = StatementLine.find(params[:id])
  end

  # POST /statement_lines
  # POST /statement_lines.json
  def create
    @statement_line = StatementLine.new(params[:statement_line])

    respond_to do |format|
      if @statement_line.save
        format.html { redirect_to @statement_line, notice: 'Statement line was successfully created.' }
        format.json { render json: @statement_line, status: :created, location: @statement_line }
      else
        format.html { render action: "new" }
        format.json { render json: @statement_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statement_lines/1
  # PUT /statement_lines/1.json
  def update
    @statement_line = StatementLine.find(params[:id])

    respond_to do |format|
      if @statement_line.update_attributes(params[:statement_line])
        format.html { redirect_to @statement_line, notice: 'Statement line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statement_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statement_lines/1
  # DELETE /statement_lines/1.json
  def destroy
    @statement_line = StatementLine.find(params[:id])
    @statement_line.destroy

    respond_to do |format|
      format.html { redirect_to statement_lines_url }
      format.json { head :no_content }
    end
  end
end

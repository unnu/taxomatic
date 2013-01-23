class TaxController < ApplicationController

  before_filter :make_date_from_params, :only => :ust
  
  def ust
    @declaration = TaxDeclaration.for_date(@date)
  end
  
  private
  
    def make_date_from_params
      month = (params[:month] || Date.today.month).to_i
      year = (params[:year] || Date.today.year).to_i
      @date = Date.new(year, month)
    end
  
end

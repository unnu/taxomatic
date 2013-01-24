class TaxController < ApplicationController

  before_filter :make_date_from_params, :only => :ust
  
  def ust
    @declaration = TaxDeclaration.for_date(@date)
  end
  
  private
  
    def make_date_from_params
      @date = if (params[:month] && params[:year])
        Date.new(params[:year].to_i, params[:month].to_i)
      else
        Date.today - 1.month
      end
    end
  
end

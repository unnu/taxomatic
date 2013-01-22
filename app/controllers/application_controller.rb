# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base

  before_filter :set_charset

  def set_charset
    headers['Content-Type'] = 'text/html; charset=Windows-1252'
  end

  protected
  
    # used in invoice and website controller
    def get_clients
      client = Client.all(:order => 'name')
      client.unshift(Client.new(:id => 0, :name => '--- Bitte waehlen ---'))
      client.map {|c| [c.name, c.id]}
    end
  
end

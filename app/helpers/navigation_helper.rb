module NavigationHelper
  
  def navigation
    yield NavigationBuilder.new(self)
  end
  
  class NavigationBuilder
    
    attr_reader :helper
    
    def initialize(helper_context)
      @helper = helper_context
    end
    
    def add(title, path, link_options = {})
      helper.active_link_to(title, path, link_options)
    end
    
  end

end
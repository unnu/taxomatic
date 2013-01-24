module NavigationHelper
  
  def navigation
    yield NavigationBuilder.new(self)
  end
  
  class NavigationBuilder
    
    attr_reader :helper, :first_item_rendered
    
    def initialize(helper_context)
      @helper = helper_context
    end
    
    def add(title, path, link_options = {})
      classes = []
      classes << 'first' if !first_item_rendered
      @first_item_rendered = true
      classes << 'current' if helper.current_page?(path)
      helper.link_to(title, path, link_options.merge(:class => classes))
    end
    
  end

end
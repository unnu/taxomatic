ActionController::Routing::Routes.draw do |map|
  
  map.resources :expenses
  map.resources :invoices
  
  map.root :controller => 'index'

  map.expenses_for_year 'expenses/list/:year', :controller => 'expenses'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end

ActionController::Routing::Routes.draw do |map|
  
  map.resources :expenses
  map.resources :invoices
  
  map.expenses_for_year 'expenses/list/:year', :controller => 'expenses'
  map.invoices_for_year 'invoices/list/:year', :controller => 'invoices'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'


  map.root :controller => 'tax', :action => 'ust'
end

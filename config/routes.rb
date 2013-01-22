ActionController::Routing::Routes.draw do |map|
  
  map.resources :expenses
  map.resources :invoices
  
  match 'expenses/list/:year' => 'expenses#index', :as => 'expenses_for_year'
  match 'invoices/list/:year' => 'invoices#index', :as => 'invoices_for_year'
  
  root :to => "tax#ust"
  match "/:controller(/:action(/:id))(.:format)"
end

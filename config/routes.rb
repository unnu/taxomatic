Git::Application.routes.draw do
  
  resources :expenses
  resources :invoices
  
  match 'expenses/yearly/:year' => 'expenses#index', :as => 'expenses_for_year'
  match 'invoices/yearly/:year' => 'invoices#index', :as => 'invoices_for_year'
  
  root :to => "tax#ust"
  match "/:controller(/:action(/:id))(.:format)"
  
end

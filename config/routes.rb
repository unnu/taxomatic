Git::Application.routes.draw do
  
  resources :expenses
  resources :expense_categories
  resources :clients
  resources :invoices
  resources :statement_lines do
    put 'update_expense', on: :member
  end
  
  match 'expenses/yearly/:year' => 'expenses#index', :as => 'expenses_for_year'
  match 'invoices/yearly/:year' => 'invoices#index', :as => 'invoices_for_year'

  match "/tax/ust(/:year(/:month))", :to => "tax#ust", :as => 'ust_tax_declaration'
  
  root :to => "tax#ust"
  match "/:controller(/:action(/:id))(.:format)"
  
end

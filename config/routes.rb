ActionController::Routing::Routes.draw do |map|
  map.resources :historic_costs

  map.resources :historic_projects

  map.resources :users

  map.resource :session

  map.resources :projects

  map.resources :companies

  map.resources :rate_types

  map.resources :people

  map.resources :person_projects, :collection => { :profit => :any, :graph_code => :any, :dashboard => :any }

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
     map.connect '/person_projects/destroy/:id/:requested_date', :controller => 'person_projects', :action => 'destroy'
     map.connect '/person_projects/graph_code/:requested_date/:count/:project_id', :controller => 'person_projects', :action => 'graph_code'
     map.connect '/person_projects/profit/:requested_date', :controller => 'person_projects', :action => 'profit'
     map.connect '/person_projects/dashboard/:requested_date', :controller => 'person_projects', :action => 'dashboard'
     map.connect '/person_projects/dashboard/:requested_date/:from/:to/:project_id', :controller => 'person_projects', :action => 'dashboard'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
   map.root :controller => "people"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

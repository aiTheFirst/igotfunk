ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
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

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"
  
  map.refresh_chart 'charts/:limit/:chart_type', :controller => 'chart', :action => 'index'
  
  map.home '/beta', :controller => 'home', :action => 'index'
  
  map.create_comment 'stories/:story_id/create/comment', :controller => 'story_comments', :action => 'create'
  
  map.update_ranking 'rankings/update/:story_id/:score', :controller => 'rankings', :action => 'update'
  
  map.new_story '/new/story', :controller => 'stories', :action => 'new'
  map.create_story '/create/story', :controller => 'stories', :action => 'create'
  
  map.view_story_category '/categories/:story_category_slug', :controller => 'story_categories', :action => 'index'
  map.view_story_category_by_page '/categories/:story_category_slug/page/:page_num', :controller => 'story_categories', :action => 'index'
  
  map.view_tag '/tags/:tag_slug', :controller => 'tags', :action => 'index'
  
  map.view_story '/stories/:name', :controller => 'stories', :action => 'index'
  map.edit_story '/stories/:name/edit', :controller => 'stories', :action => 'edit'
  map.update_story '/stories/:name/update', :controller => 'stories', :action => 'update'
  map.destroy_story '/stories/:name/destroy', :controller => 'stories', :action => 'destroy'
  
  map.create_status '/status/create', :controller => 'status', :action => 'create'
  map.status '/status', :controller => 'status', :action => 'new'
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.create_user '/signup/process', :controller => 'users', :action => 'create'
  map.view_user 'users/:user_name', :controller => 'users', :action => 'index'
  map.edit_user 'users/:user_name/edit', :controller => 'users', :action => 'edit'
  map.update_user 'users/:user_name/update', :controller => 'users', :action => 'update'
  
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.create_session '/new/session', :controller => 'sessions', :action => 'create'
  
  map.update_ranking '/rankings/update/', :controller => 'rankings', :action => 'update'
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

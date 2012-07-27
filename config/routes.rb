ActionController::Routing::Routes.draw do |map|
#  map.resources :comments
#  map.resources :entries
#  map.connect 'entries/:permalink', :controller => 'entries', :action => 'show'
#  map.connect ':controller/:action/:name'

# need the following for correct pagination of group specific entries
  map.connect 'groups/:name', :controller => 'groups', :action => 'show'
  map.fanas 'groups/:name/fanas', :controller => 'groups', :action => 'show_all_users'
  map.hinchas 'hinchas/:login', :controller => 'users', :action => 'show'

  map.resources :users
  map.resources :sessions
  map.resources :tags

  # will connect urls like groups/1/entries/5/comments/8
  # 1 is the group_id, 5 is the entry_id, 8 is the comment_id
  
  map.resources :groups, :member_path => 'groups/:name', :collection => { :show_by_name => :get } do |group|
    group.resources :entries, :collection => { :newtexto => :get, :newlink => :get, :newphoto => :get, :newquote => :get } do |entry|
      entry.resources :comments
    end
  end
  
  #map.resources :groups do |groups|
  #  groups.resources :entries #do |entry|
      #entry.resources :comments
    #end
  #end
  
  # connects urls like categories/1/entries
#  map.resources :categories do |categories|
 #   categories.resources :entries
#  end

  # Install the default routes as the lowest priority.
  #map.connect 'groups/:name', :action => 'show_by_name'
  #map.connect ':controller/:action/:name'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  #map.connect ':controller/:action/:name'
  #map.connect 'equipo/:name', :controller => 'groups', :action => 'show_by_name'
  
  map.index '/', :controller => 'groups', :action => 'index'
  #map.activate '/activate/:activation_code', :controller => 'hinchas', :action => 'activate', :activation_code => nil
  map.signup '/registro', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/salir', :controller => 'sessions', :action => 'destroy'
  map.profile '/perfil', :controller => 'users', :action => 'my_profile'
  map.forgot '/forgot', :controller => 'users', :action => 'forgot'
  map.reset 'reset/:reset_code', :controller => 'users', :action => 'reset'
end

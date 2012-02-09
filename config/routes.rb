Tukiosquito::Application.routes.draw do

  root :to => 'tienda#index'
 
  #CLIENTES
  match "iniciar_sesion" => "clientes#iniciar_sesion", :as => "iniciar_sesion_cliente"
  get "cerrar_sesion" => "clientes#cerrar_sesion", :as => "cerrar_sesion_cliente"
  get "registro" => "clientes#new", :as => "registro_cliente"
  
  #ADMINISTRADORES
  match "iniciar_como_admin" => "administradores#iniciar_sesion", :as => "iniciar_sesion_admin"
  get "cerrar_como_admin" => "administradores#cerrar_sesion", :as => "cerrar_sesion_admin"
  
  #PRODUCTOS
  match "c-:cat_id(/sc-:subcat_id)" => "tienda#index"
  
  #CARRITO Y TIENDA
  match "/agregar_al_carro" => "tienda#agregar_al_carro"
  match "/quitar_del_carro" => "tienda#quitar_del_carro"
  match "/vaciar_carro" => "tienda#vaciar_carro"
  match "/carrito" => "tienda#carrito", :as => "carrito"
  match "/carrito/cambiar_cantidad" => "tienda#cambiar_cantidad"
  match "/ver_ordenes" => "tienda#ver_ordenes", :as => "ver_ordenes"

  #RECURSOS GENERALES
  resources :subcategorias
  resources :categorias
  resources :facturas_distribuidores
  resources :productos
  resources :ventas
  resources :ordenes
  resources :administradores
  resources :tdc
  resources :clientes

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
end

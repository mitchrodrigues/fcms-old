Rails.application.routes.draw do
  namespace :v1 do
    resources :organization
    resources :groups    

    resources :children do
      # TODO: Probably move this to its own controller
      member do
        # Placements
        get    'placement', action: :show
        post   'placement', action: :placement_start
        delete 'placement', action: :placement_end

        get  :notes
        post :notes, action: :create_note

      end # / Member

      collection do
        get :case_load
        get :mapping


        post '/case_load/search', action: :case_load_search

        post :search
      end # / collection

    end # / children

    resources :offices, as: :offices do 
      collection do 
        get :current
      end
    end

    resources :session, only: [:create, :index] do
      collection do
        delete '/', action: :destroy
      end
    end

    match 'session',
            controller: 'base',
            via: :options, 
            action: :options_route

    match 'children(/:id)',
            controller: 'base',
            via: :options, 
            action: :options_route
   
  end
end
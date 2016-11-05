Rails.application.routes.draw do
  # resources :facilities,    except: [:new, :edit]
  # resources :offices,       except: [:new, :edit]
  # resources :children,      except: [:new, :edit]
  # resources :organizations, except: [:new, :edit] do
  #   member do
  #     get :roster, as: :roster_path
  #   end
  # end


  namespace :v1 do
    resources :organization

    resources :children do
      # TODO: Probably move this to its own controller
      member do
        # Placements
        get    'placement', action: :show
        post   'placement', action: :placement_start
        delete 'placement', action: :placement_end
      end # / Member

      collection do
        get :case_load
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
  end
end

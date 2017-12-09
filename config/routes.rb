Rails.application.routes.draw do
  get 'home/index'
  
  resources :articles do 
    collection do 
      post :import_json
      post :import_csv
      get :export_json
      get :export_csv
      get :export_excel
    end
  end

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

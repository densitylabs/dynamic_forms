DynamicForms::Engine.routes.draw do
  resources :custom_forms do
    resources :submissions
  end

  post 'form/:uuid', to: 'api/form#create', as: :api_form
  get 'form/:uuid', to: 'api/form#show', as: :api_form_schemas
end

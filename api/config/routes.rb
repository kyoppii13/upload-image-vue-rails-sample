Rails.application.routes.draw do
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :items
      resources :item_images, only: :index do
        post 'upload', to: 'item_images#upload', on: :collection
      end
    end
  end
end

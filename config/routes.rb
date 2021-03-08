Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: 'user/users#top'


  # 以下adminのルートパス
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update] do
      collection do
        get 'leave' => 'users#leave'
      end
    end
  end

  namespace :admin do
    resources :shops, only: [:new, :index, :show, :edit, :update, :destroy] do
      collection do
        get 'delete' => 'shops#delete'
      end
      resources :shop_images, only: [:destroy]
    end
  end

  # ジャンル直下にshopを置きたくないので、shopとは別に設定しています
  namespace :admin do
    resources :genres, only: [:new, :index, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    resources :newses
  end



  # 以下userのルートパス
  scope module: :user do
    resources :users, only: %i(show edit update destroy) do
      collection do
        get 'top'
        get 'about'
        get 'quit'
        patch 'out'
        delete 'registration'
      end
    end
  end

  scope module: :user do
    resources :shops, only: [:new, :create, :index, :show] do
      # resourcesだとurlにshop_idを介してしまい、
      # 全体のランキングページを表示できないので、collection doで別にしています
      collection do
        get 'reviews' => 'reviews#index'
      end
      resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy]

      # resourcesだとurlにshop_idを介してしまい、
      # 特定のユーザーがブックマークしたもののみを表示できないので、collection doで別にしています
      collection do
        get 'bookmark' => 'bookmarks#show'
      end

      resource :bookmarks, only: %i(create destroy)
    end
  end

  scope module: :user do
    resources :searches, only: [:index] do
      collection do
        get 'placegenre' => 'searches#placegenre'
      end
    end
  end

  scope module: :user do
    resources :contacts, only: %i(new create)
  end

  scope module: :user do
    resources :newses, only: %i(index show)
  end
end

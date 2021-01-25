Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'user/users#top'

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
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

  namespace :user do
    resources :users, only: %i[show edit update] do
      collection do
        get 'top'
        get 'about'
        get 'quit'
        patch 'out'
      end
    end
  end

  namespace :user do
    resources :shops, only: [:new, :create, :index, :show] do
      # resourcesだとurlにshop_idを介してしまい
      # 全体のランキングページを表示できないので、collection doで別にしている
      collection do
        get 'reviews' => 'reviews#index'
      end
      resources :reviews, only: [:new, :create, :show, :edit, :update, :destroy]

      # resourcesだとurlにshop_idを介してしまい特定のユーザーが
      # ブックマークしたもののみを表示できないので、collection doで別にしている
      collection do
        get 'bookmark' => 'bookmarks#show'
      end

      resource :bookmarks, only: %i[create destroy]
    end
  end

  namespace :user do
    resources :searches, only: [:index] do
      collection do
        get 'placegenre' => 'searches#placegenre'
      end
    end
  end

  namespace :user do
    resources :contacts, only: %i[new create]
  end

  namespace :user do
    resources :newses, only: %i[index show]
  end
end

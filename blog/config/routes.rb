Rails.application.routes.draw do
  #get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Railsでは、ルーティングを1つずつ手作りするよりもresourcesオブジェクトを使用してルーティングを設定することが推奨されています。 
  #ルーティングの詳細については、本ガイドのRailsのルーティングを参照してください。
  #https://railsguides.jp/routing.html
  #resources :articles
  #コメント追加により↑を修正
  resources :articles do
  	resources :comments
  end
  
  root 'welcome#index'  
end

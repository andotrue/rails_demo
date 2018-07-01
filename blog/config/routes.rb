Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    # /welcome/indexというリクエストをwelcomeコントローラのindexアクションに割り当てます。
    #get 'welcome/index'

    #Railsでは、ルーティングを1つずつ手作りするよりもresourcesオブジェクトを使用してルーティングを設定することが推奨されています。 
    #ルーティングの詳細については、本ガイドのRailsのルーティングを参照してください。
    #https://railsguides.jp/routing.html
    #resources :articles
    #コメント機能追加により↑を修正
    resources :articles do
        # articleの内側に ネストされたリソースとしてcommentsが作成されます。
        # これは、モデルの記述とは別の視点から、記事とコメントの間のリレーションシップを階層的に捉えたものであると言えます。
        resources :comments
    end

    # アプリケーションのルートURLへのアクセスをwelcomeコントローラのindexアクションに割り当てるようRailsに指示が伝わります。
    root 'welcome#index'  
end

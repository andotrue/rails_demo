class ArticlesController < ApplicationController

	#BASIC認証
	#indexアクションとshowアクションは自由にアクセスできるようにし、それ以外のアクションには認証を要求する
	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	def new
		@article = Article.new
	end

	def create
		# 実際のパラメータがどのようになっているかを確認するために、
		# フォームから送信されたパラメータをそのまま表示
		#render plain: params[:article].inspect

		# 不正なマスアサインメントを防止するため、article_paramsを使用
		#@article = Article.new(params[:article])
		@article = Article.new(article_params)
	 
		if @article.save
			redirect_to @article
		else
			# saveの結果がfalseの場合には、redirect_toではなく、newテンプレートに対するrenderを実行
			# renderメソッドを使用する理由は、ビューのnewテンプレートが描画されたときに、@articleオブジェクトがビューのnewテンプレートに返されるようにするためです。
			# renderによる描画は、フォームの送信時と同じリクエスト内で行われます。
			# 対照的に、redirect_toはサーバーに別途リクエストを発行するようブラウザに対して指示するので、やりとりが1往復増えます。
			render 'new'
		end
 	end

	def show
		# Article.findを使用して、取り出したい記事をデータベースから探しています。
		# このとき、リクエストの:idパラメータを取り出すためにparams[:id]を引数としてfindに渡しています。
		# そして、取り出した記事オブジェクトへの参照を保持するために、通常の変数ではなく、インスタンス変数 (@が頭に付いているのが印です) 
		# が使用されている点にもご注目ください。
		# これは、Railsではコントローラのインスタンス変数はすべてビューに渡されるようになっているからです
		# (訳注: Railsはそのために背後でインスタンス変数をコントローラからビューに絶え間なくコピーし続けています)。
		@article = Article.find(params[:id])
	end
 	
	def index
	  @articles = Article.all
	end

	def edit
	  @article = Article.find(params[:id])
	end

	def update
	  @article = Article.find(params[:id])
	 
	  if @article.update(article_params)
	    redirect_to @article
	  else
	    render 'edit'
	  end
	end

	def destroy
	  @article = Article.find(params[:id])
	  @article.destroy
	 
	  redirect_to articles_path
	end

	# コントローラで渡されるパラメータはホワイトリストでチェックし、不正なマスアサインメントを防止する必要があるのです。
	# この場合、createでパラメータを安全に使用するために、titleとtextパラメータの利用を「許可」し、かつ「必須」であることを指定したいのです。
	# この指定を文法化するために、requireメソッドとpermitメソッドが導入されました。これに基いて、該当行を以下のように変更します。
 	private
		def article_params
			params.require(:article).permit(:title, :text)
 		end
 end

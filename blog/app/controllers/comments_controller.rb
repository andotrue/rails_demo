class CommentsController < ApplicationController

  #BASIC認証
  #destroyアクションはアクションには認証を要求する
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    @article = Article.find(params[:article_id])
    #@article.commentsに対してcreateメソッドを実行することで、コメントの作成と保存を同時に行っています
    #(訳注: buildメソッドにすれば作成のみで保存は行いません)。
    #この方法でコメントを作成すると、コメントと記事が自動的にリンクされ、指定された記事に対してコメントが従属するようになります。
    @comment = @article.comments.create(comment_params)
    #新しいコメントの作成が完了したら、article_path(@article)ヘルパーを使用して元の記事の画面に戻ります。
    #このヘルパーを呼び出すとArticlesControllerのshowアクションが呼び出され、show.html.erbテンプレートが描画されます。
    redirect_to article_path(@article)
  end

  def destroy
  	#まずどの記事が対象であるかを検索して@articleに保存
    @article = Article.find(params[:article_id])
    #@article.commentsコレクションの中のどのコメントが対象であるかを特定
    @comment = @article.comments.find(params[:id])
    #データベースから削除
    @comment.destroy
    #終わったら記事のshowアクションに戻ります。
    redirect_to article_path(@article)
  end

    private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end

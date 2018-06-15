class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body

      # 以下の行によって`article_id`という整数カラムが追加される
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end

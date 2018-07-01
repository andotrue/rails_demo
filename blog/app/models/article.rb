=begin 
ApplicationRecordを継承
更にApplicationRecordはActiveRecord::Baseクラスを継承
Active Recordは、
基本的なデータベースCRUD (Create、Read、Update、Destroy) 操作、
データの検証 (バリデーション)、
洗練された検索機能、
複数のモデルを関連付ける(リレーションシップ) など、
きわめて多くの機能をRailsモデルに無償で提供しています。
=end
class Article < ApplicationRecord
	# コメントとの関連付け
	# Active Recordの関連付けの詳細については、Active Recordの関連付け(アソシエーション)ガイドを参照してください。
	# https://railsguides.jp/association_basics.html
	#has_many :comments

	# ある記事を削除したら、その記事に関連付けられているコメントも一緒に削除する必要があります。
	# そうしないと、コメントがいつまでもデータベース上に残ってしまいます。
	# Railsでは関連付けにdependentオプションを指定することでこれを実現しています。
	# 以下のように変更
	has_many :comments, dependent: :destroy

	# すべての記事にタイトルが存在し、その長さが5文字以上であることが保証されます。そうでない場合には記事はデータベースに保存されません。
	# 検証の詳細については
	# https://railsguides.jp/active_record_validations.html
	validates :title, presence: true,length: { minimum: 5 }
end

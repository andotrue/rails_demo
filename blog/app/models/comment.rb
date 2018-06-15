class Comment < ApplicationRecord
  #Active Recordの 関連付け (アソシエーション) を設定するため
  belongs_to :article
end

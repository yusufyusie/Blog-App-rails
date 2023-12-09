class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end

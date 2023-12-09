class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  # Updates the posts counter for the user
  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  # Returns the 5 most recent comments for a given post
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end

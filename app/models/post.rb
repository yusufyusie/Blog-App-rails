class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  # Updates the posts counter for the user
  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  # Returns the 5 most recent comments for a given post
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end

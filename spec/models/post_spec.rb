require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create_user }

  subject do
    Post.new(user_id: user.id, title: 'Hello', text: 'This is my post', comment_counter: 1, likes_counter: 1)
  end

  context 'Testing validation' do
    it 'Title should be invalid with nil value' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'Title must not exceed 250 characters' do
      expect(subject.title.length).to be <= 250
    end

    it 'CommentsCounter must be an integer greater than or equal to zero' do
      subject.comment_counter = -1
      expect(subject).not_to be_valid
    end

    it 'LikesCounter must be an integer greater than or equal to zero' do
      subject.likes_counter = -1
      expect(subject).not_to be_valid
    end
  end

  describe 'Functionality' do
    let(:user) { create_user(posts_counter: 0) }

    subject do
      Post.new(
          title: 'Test Post',
          text: 'This is a test post',
          user:,
          comment_counter: 0,
          likes_counter: 0
      )
    end

    it 'increases the posts_counter of the author when update_post_counter is called' do
      expect { subject.update_post_counter }.to change { user.posts_counter }.by(1)
    end

    it 'returns the five most recent comments' do
      10.times do |i|
        Comment.create(
            text: "This is the text for comment #{i}",
            post:,
            user:
        )
      end

      expect(subject.recent_comments.length).to eq(5)
    end

    it 'updates the posts_counter of the author after saving' do
      expect { subject.save }.to change { user.posts_counter }.by(1)
    end
  end
end

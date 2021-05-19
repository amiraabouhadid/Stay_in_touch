require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'amira', email: 'amira@gmail.com', password: '123456')
  describe 'User functions' do
    it "returns user's name" do
      expect(user.name).to eq('amira')
    end
    it 'returns correct password' do
      expect(user.password).to eq('123456')
    end
    it 'returns correct email' do
      expect(user.email).to eq('amira@gmail.com')
    end

    it 'returns correct pending friendships' do
      expect(user.pending_friends).to eq([])
    end

    it 'returns correct friend requests' do
      expect(user.friend_requests).to eq([])
    end
    it 'returns correct friends' do
      expect(user.friends).to eq([])
    end
  end
  describe 'User Associations' do
    it 'has many posts' do
      expect { should has_many(posts) }
    end
    it 'has many comments' do
      expect { should has_many(comments) }
    end
    it 'has many likes' do
      expect { should has_many(likes) }
    end
    it 'has many inverse friendships' do
      expect { should has_many(inverse_friendships).with_foreign_key }
    end
  end
end

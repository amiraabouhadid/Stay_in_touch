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
    it 'has many pending friendships' do
      expect { should has_many(pending_friends).with_foreign_key }
    end
    it 'has many friendships requests' do
      expect { should has_many(friend_requests).with_foreign_key }
    end
    it 'has many confirmed friendships' do
      expect { should has_many(friends) }
    end
  end
end
feature 'User can sign in' do
  scenario 'user can sign in' do
    user1 = User.create!(name: 'amira', password: '123456', email: 'amira@gmail.com')
    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'
    expect { should have_content('Signed in successfully.') }
  end
end
feature 'User can sign up' do
  scenario 'user can sign up' do
    visit new_user_registration_path
    user1 = ['amira', '123456', 'amira@gmail.com']

    fill_in 'user[name]', with: user1[0]
    fill_in 'user[email]', with: user1[2]
    fill_in 'user[password]', with: user1[1]
    fill_in 'user[password_confirmation]', with: user1[1]
    click_on 'Sign up'

    expect { should have_content('Welcome! You have signed up successfully.') }
  end
end

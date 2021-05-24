require 'rails_helper'
RSpec.describe Friendship, type: :model do
  describe 'friendship associations' do
    it 'belongs to user' do
      expect { should belongs_to(user) }
    end
    it ' belongs to friend' do
      expect { should belongs_to(friend) }
    end
  end
end
feature 'User can create new friendship' do
  scenario 'user can add friend' do
    user1 = User.create!(name: 'amira', password: '123456', email: 'amira@gmail.com')
    user2 = User.create!(name: 'david', password: '123456', email: 'david@gmail.com')

    visit new_user_registration_path
    fill_in 'user[name]', with: user1.name
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    fill_in 'user[password_confirmation]', with: user1.password
    click_on 'Sign up'

    visit new_user_registration_path
    fill_in 'user[name]', with: user2.name
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: user2.password
    fill_in 'user[password_confirmation]', with: user2.password
    click_on 'Sign up'

    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'

    visit users_path
    click_button 'Add Friend'
    expect { should have_content('Request sent') }
  end
  scenario 'user can accept friend request' do
    user1 = User.create!(name: 'amira', password: '123456', email: 'amira@gmail.com')
    user2 = User.create!(name: 'david', password: '123456', email: 'david@gmail.com')

    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'

    visit users_path
    click_button 'Add Friend'
    click_on 'Sign out'

    visit user_session_path
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: user2.password
    click_on 'Log in'

    visit users_path
    expect { should have_content('Accept') }
  end
  scenario 'user can decline friend request' do
    user1 = User.create!(name: 'amira', password: '123456', email: 'amira@gmail.com')
    user2 = User.create!(name: 'david', password: '123456', email: 'david@gmail.com')

    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'

    visit users_path
    click_button 'Add Friend'
    click_on 'Sign out'

    visit user_session_path
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: user2.password
    click_on 'Log in'

    visit users_path

    expect { should have_content('Decline') }
  end
end

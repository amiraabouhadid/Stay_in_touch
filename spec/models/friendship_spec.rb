  # rubocop: disable Lint/UselessAssignment
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
    user1 = User.create!(name: 'amira', password: '123456',
                         email: 'amira@gmail.com')

    user2 = User.create!(name: 'david', password: '123456',
                         email: 'david@gmail.com')

    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'

    visit users_path
    click_on 'Add'
    expect { should have_content('Request sent') }
  end
end
feature 'User can accept friendship request' do
  scenario 'user can accept friend request' do
    user1 = User.create!(name: 'amira', password: '123456',
                         email: 'amira@gmail.com')

    user2 = User.create!(name: 'david', password: '123456',
                         email: 'david@gmail.com')

    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'

    visit users_path
    click_on 'Add'
    click_on 'Sign out'

    visit user_session_path
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: user2.password
    click_on 'Log in'

    visit users_path
    expect { should have_content('Accept') }
  end
end
feature 'User can reject friendship request' do
  scenario 'user can reject friend request' do
    user1 = User.create!(name: 'amira', password: '123456',
                         email: 'amira@gmail.com')
    user2 = User.create!(name: 'david', password: '123456',
                         email: 'david@gmail.com')

    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'

    visit users_path
    click_on 'Add'
    click_on 'Sign out'

    visit user_session_path
    fill_in 'user[email]', with: user2.email
    fill_in 'user[password]', with: user2.password
    click_on 'Log in'

    visit users_path

    expect { should have_content('Reject') }
  end
end
# rubocop: enable Lint/UselessAssignment

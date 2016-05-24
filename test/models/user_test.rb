require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'find_or_create_from should create user when user does not exist' do
    auth_hash = {
      provider: 'github',
      uid: 666,
      info: {
        nickname: 'madhatter'
      }
    }

    assert_difference('User.count') do
      User.find_or_create_from(auth_hash)
    end

    assert_equal auth_hash[:provider], User.last.provider
    assert_equal auth_hash[:uid].to_s, User.last.uid
    assert_equal auth_hash[:info][:nickname], User.last.nickname
  end

  test 'find_or_create_from should not create user when user already exist' do
    auth_hash = {
      provider: 'github',
      uid: 42,
      info: {
        nickname: 'alice'
      }
    }

    assert_no_difference('User.count') do
      User.find_or_create_from(auth_hash)
    end

    user = User.find_by(nickname: 'alice')

    assert_equal auth_hash[:provider], user.provider
    assert_equal auth_hash[:uid].to_s, user.uid
    assert_equal auth_hash[:info][:nickname], user.nickname
  end
end

class User < ActiveRecord::Base
  include Authenticator

  has_many :posts

  class << self
    def find_or_create_from(auth)
      find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
        user.nickname = auth[:info][:name]
      end
    end
  end
end

class User < ActiveRecord::Base
  include Authenticator

  has_many :posts, foreign_key: "created_by_id"

  class << self
    def find_or_create_from(auth)
      find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
        user.nickname = auth[:info][:nickname]
      end
    end
  end
end

class User < ActiveRecord::Base
  has_many :posts

  def self.find_or_create_from(auth)
    find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
      user.nickname = auth[:info][:nickname]
    end
  end
end

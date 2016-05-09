class Post < ApplicationRecord
  belongs_to :user

  def body_html
    Kramdown::Document.new(body).to_html
  end
end

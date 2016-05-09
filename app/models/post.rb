class Post < ApplicationRecord
  belongs_to :user

  def body_html
    Kramdown::Document.new(body, input: 'GFM', syntax_highlighter: 'rouge').to_html
  end
end

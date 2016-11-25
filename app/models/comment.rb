class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commented_by, class_name: "User"
end

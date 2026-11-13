class Comment < ApplicationRecord
  belongs_to :bug, optional: false
  belongs_to :user, optional: false
end

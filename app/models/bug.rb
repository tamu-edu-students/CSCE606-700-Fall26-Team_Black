class Bug < ApplicationRecord
    belongs_to :project
    belongs_to :user
    has_many :comments
end

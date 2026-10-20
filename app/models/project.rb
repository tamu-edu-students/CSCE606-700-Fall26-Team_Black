class Project < ApplicationRecord
    validates :name, presence: true
    has_many :bugs
end

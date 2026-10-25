class Project < ApplicationRecord
    validates :name, presence: true
    has_many :bugs
    belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
end

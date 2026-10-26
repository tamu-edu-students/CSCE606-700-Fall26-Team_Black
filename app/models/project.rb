class Project < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
  has_many :bugs
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
end

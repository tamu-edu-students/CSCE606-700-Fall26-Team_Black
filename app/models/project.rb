class Project < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
  has_many :bugs, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  def manageable_by?(user)
    owner_id == user.id || memberships.exists?(user: user, role: "admin")
  end

  def deletable_by?(user)
    owner_id == user.id
  end
end

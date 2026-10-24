class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  ROLES = %w[developer manager admin].freeze

  validates :role, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :project_id }
end

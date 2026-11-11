class Bug < ApplicationRecord
    belongs_to :project
    belongs_to :user
    has_many :comments, dependent: :destroy

    PRIORITY = %w[urgent routine low].freeze
    STATUS =%w[open in\ progress closed].freeze
end

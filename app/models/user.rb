class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :owned_projects, class_name: "Project", foreign_key: "owner_id", dependent: :destroy
  has_many :bugs
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

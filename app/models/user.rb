class User < ApplicationRecord
  has_many :stores
  has_many :user_roles
  has_many :roles, through: :user_roles

  def has_role? role
    roles.pluck(:name).include? role.to_s
  end

  def self.authenticate(u,p)
    User.where(username: u, password: p).first
  end

end

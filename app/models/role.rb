class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  def self.admin
    find_by_name("admin")
  end

  def self.user
    find_by_name("user")
  end
  
end

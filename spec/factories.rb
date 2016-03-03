FactoryGirl.define do

  factory :admin_role, class: Role do
    name 'admin'
  end
  factory :user_role, class: Role do
    name 'user'
  end

  factory :admin, class: User do
    name 'admin'
    email 'admin@example.com'
    username 'admin'
    password 'admin'
    before(:create){|u| u.roles = [create(:admin_role)]}
  end

  factory :user do
    name 'user'
    email 'user@example.com'
    username 'user'
    password 'user'
    before(:create){|u| u.roles = [create(:user_role)]}
  end

  factory :store do
    name 'fake store'
    address 'fake address'
    user
  end

  factory :product do
    name 'fake product'
    price 100
    store    
  end

end
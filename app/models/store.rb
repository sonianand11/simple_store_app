class Store < ApplicationRecord
  has_many :products, dependent: :destroy  
end

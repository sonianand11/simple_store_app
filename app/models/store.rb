class Store < ApplicationRecord
  has_many :products
  belongs_to :store, dependent: :destroy
end

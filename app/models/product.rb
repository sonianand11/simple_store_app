class Product < ApplicationRecord
  belongs_to :store, dependent: :destroy
end

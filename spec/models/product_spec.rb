require 'rails_helper'

RSpec.describe Product, :type => :model do
  
  it 'belongs to store' do    
    expect(Product.reflect_on_association(:store).macro).to eq :belongs_to
  end

  it 'destroies if store store destroy' do
    store = FactoryGirl.create(:store)
    product = FactoryGirl.create(:product,store_id: store.id)

    expect { store.destroy}.to change(Product,:count).by(-1)
  end

end

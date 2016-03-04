require 'rails_helper'

RSpec.describe Store, :type => :model do
  
  it 'has many products' do    
    expect(Store.reflect_on_association(:products).macro).to eq :has_many
  end

  it 'belongs to user' do
    expect(Store.reflect_on_association(:user).macro).to eq :belongs_to
  end

end

require 'rails_helper'

RSpec.describe User, :type => :model do
  
  it 'has many stores' do    
    expect(User.reflect_on_association(:stores).macro).to eq :has_many
  end

end

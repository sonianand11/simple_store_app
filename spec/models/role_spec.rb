require 'rails_helper'

RSpec.describe Role, :type => :model do
  
  it 'has many users' do    
    expect(Role.reflect_on_association(:users).macro).to eq :has_many
  end

end

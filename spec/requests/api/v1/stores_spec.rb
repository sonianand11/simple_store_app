require 'rails_helper'

RSpec.describe Api::V1::StoresController, :type => :request do
  
  let!(:store) {FactoryGirl.create(:store)}
  let(:admin_user) {FactoryGirl.create(:admin_user)}
  let(:user) {FactoryGirl.create(:user)}

  describe '#index' do
    it 'sends a list of stores' do  
            
      get api_v1_stores_path

      json = parse_response(response.body)
      expect(response).to be_success
      expect(json.length).to eq(1)
    end
  end

  describe '#show' do
    it 'returns store information' do
      get api_v1_store_path(store)
      json = parse_response(response.body)      
      expect(json[:id]).to eq(store.id)
      expect(json[:name]).to eq(store.name)      
    end
  end

  describe '#create' do
    it 'creates store with valid user' do
      
      store_attributes = FactoryGirl.attributes_for :store

      post api_v1_stores_path,
        params: {store: store_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
      
      json = parse_response(response.body)      
      expect(json[:name]).to eq(store_attributes[:name])
      expect(json[:address]).to eq(store_attributes[:address])
    end

    it 'response with access denied' do
      
      store_attributes = FactoryGirl.attributes_for :store

      post api_v1_stores_path,
        params: {store: store_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth('wrong_username', 'wrong_password')}
      
      expect(response.body.strip).to eq('HTTP Basic: Access denied.')
      expect(response).to be_unauthorized
    end

  end

  describe '#update' do
    it 'update store with valid user' do
      
      store_attributes = FactoryGirl.attributes_for :store, name: 'updated name'

      put api_v1_store_path(store),
        params: {store: store_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
      
      json = parse_response(response.body)
      expect(json[:name]).to eq(store_attributes[:name])
      expect(json[:address]).to eq(store_attributes[:address])
    end

    it 'response with access denied' do
      
      store_attributes = FactoryGirl.attributes_for :store, name: 'updated name'

      put api_v1_store_path(store),
        params: {store: store_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth('wrong_username', 'wrong_password')}
      
      expect(response.body.strip).to eq('HTTP Basic: Access denied.')
      expect(response).to be_unauthorized
    end

    it 'response with unauthrization access message' do
      
      store_attributes = FactoryGirl.attributes_for :store, name: 'updated name'

      another_user = create(:user,username: 'another',password: 'another')

      put api_v1_store_path(store),
        params: {store: store_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth(another_user.username, another_user.password)}
      
      json = parse_response(response.body)
      expect(json[:error]).to eq('You are not authorized to access this page.')
    end

  end

  describe '#destroy' do
    it 'destroy store with valid user' do      

      expect {
        delete api_v1_store_path(store),
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
      }.to change(Store,:count).by(-1)
      expect(response).to be_success

    end

    it 'response with access denied' do
      
      delete api_v1_store_path(store)

      expect(response.body.strip).to eq('HTTP Basic: Access denied.')
      expect(response).to be_unauthorized
    end

    it 'response with unauthrization access message' do
      
      another_user = create(:user,username: 'another',password: 'another')

      delete api_v1_store_path(store),          
        env: {'HTTP_AUTHORIZATION' => basic_auth(another_user.username, another_user.password)}
      
      json = parse_response(response.body)
      expect(json[:error]).to eq('You are not authorized to access this page.')
    end

  end


end
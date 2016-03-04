require 'rails_helper'

RSpec.describe Api::V1::ProductsController, :type => :request do
  
  let!(:store) {FactoryGirl.create(:store)}
  let!(:product){FactoryGirl.create(:product,store_id: store.id)}
  let(:admin_user) {FactoryGirl.create(:admin_user)}
  let(:user) {FactoryGirl.create(:user)}


  describe '#index' do
    it 'sends a list of products' do  
            
      get api_v1_store_products_path(store)

      json = parse_response(response.body)
      expect(response).to be_success
      expect(json.length).to eq(1)
    end
  end

  describe '#show' do
    it 'returns product information' do
      get api_v1_store_product_path(store,product)
      json = parse_response(response.body)
      expect(json[:id]).to eq(product.id)
      expect(json[:name]).to eq(product.name)      
    end

    it 'response with record not found error' do
      get api_v1_store_product_path(20,20)
      json = parse_response(response.body)
      expect(json[:error]).to eq('record not available')
    end

  end

  describe '#create' do
    it 'creates product with valid user' do
      
      product_attributes = FactoryGirl.attributes_for :product,store_id: store.id

      post api_v1_store_products_path(store),
        params: {product: product_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
      
      json = parse_response(response.body)      
      expect(json[:name]).to eq(product_attributes[:name])
      expect(json[:address]).to eq(product_attributes[:address])
    end

    it 'response with access denied' do
      product_attributes = FactoryGirl.attributes_for :product,store_id: store.id

      post api_v1_store_products_path(store),
        params: {product: product_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth('wrong_username', 'wrong_password')}
      
      expect(response.body.strip).to eq('Bad credentials')
      expect(response).to be_unauthorized
    end

  end

  describe '#update' do
    it 'update product with valid user' do
      
      product_attributes = FactoryGirl.attributes_for :product,store_id: store.id, name: 'updated name'

      put api_v1_store_product_path(store,product),
        params: {product: product_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
      
      json = parse_response(response.body)
      expect(json[:name]).to eq(product_attributes[:name])
      expect(json[:address]).to eq(product_attributes[:address])
    end

    it 'response with access denied' do
      
      product_attributes = FactoryGirl.attributes_for :product,store_id: store.id, name: 'updated name'

      put api_v1_store_product_path(store,product),
        params: {product: product_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth('wrong_username', 'wrong_password')}
      
      expect(response.body.strip).to eq('Bad credentials')
      expect(response).to be_unauthorized
    end

    it 'response with unauthrization access message' do
      
      product_attributes = FactoryGirl.attributes_for :product,store_id: store.id, name: 'updated name'

      another_user = create(:user,username: 'another',password: 'another')

      put api_v1_store_product_path(store,product),
        params: {product: product_attributes},
        env: {'HTTP_AUTHORIZATION' => basic_auth(another_user.username, another_user.password)}
      
      json = parse_response(response.body)
      expect(json[:error]).to eq('You are not authorized to access this page.')
    end

  end


  describe '#destroy' do
    it 'destroy product with valid user' do      

      expect {
        delete api_v1_store_product_path(store,product),
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
      }.to change(Product,:count).by(-1)
      expect(response).to be_success

    end

    it 'response with access denied' do
      
      delete api_v1_store_product_path(store,product)

      expect(response.body.strip).to eq('Bad credentials')
      expect(response).to be_unauthorized
    end

    it 'response with unauthrization access message' do
      
      another_user = create(:user,username: 'another',password: 'another')

      delete api_v1_store_product_path(store,product),
        env: {'HTTP_AUTHORIZATION' => basic_auth(another_user.username, another_user.password)}
      
      json = parse_response(response.body)
      expect(json[:error]).to eq('You are not authorized to access this page.')
    end

  end


end
require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :request do
  
  let!(:admin_user) {FactoryGirl.create(:admin)}
  let!(:user) {FactoryGirl.create(:user)}

  describe '#index' do

    context 'admin user' do

      it 'sends a list of users' do  
        
        get api_v1_users_path,          
          env: {'HTTP_AUTHORIZATION' => basic_auth(admin_user.username, admin_user.password)}

        json = parse_response(response.body)
        expect(response).to be_success
        expect(json.length).to eq(2)

      end

    end

    context 'normal user' do

      it 'responses with unauthrization' do  
        
        get api_v1_users_path,
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}

        json = parse_response(response.body)
        expect(json[:error]).to eq('You are not authorized to access this page.')

      end

    end

  end

  describe '#show' do

    context 'admin user' do

      it 'returns user information' do

        get api_v1_user_path(user),          
          env: {'HTTP_AUTHORIZATION' => basic_auth(admin_user.username, admin_user.password)}
        json = parse_response(response.body)      
        expect(json[:id]).to eq(user.id)
        expect(json[:name]).to eq(user.name)      

      end

      it 'response with record not found error' do

        get api_v1_user_path(20),          
          env: {'HTTP_AUTHORIZATION' => basic_auth(admin_user.username, admin_user.password)}
        json = parse_response(response.body)
        expect(json[:error]).to eq('record not available')

      end

    end

    context 'normal user' do

      it 'returns own user information' do

        get api_v1_user_path(user),
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
        json = parse_response(response.body)      
        expect(json[:id]).to eq(user.id)
        expect(json[:name]).to eq(user.name)      

      end

      it 'responses with unauthrization' do  
        
        get api_v1_user_path(admin_user),
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}

        json = parse_response(response.body)
        expect(json[:error]).to eq('You are not authorized to access this page.')

      end

      it 'response with record not found error' do

        get api_v1_user_path(20),
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
        json = parse_response(response.body)
        expect(json[:error]).to eq('record not available')
        
      end
    end

  end

  describe '#create' do

    context 'admin user' do

      it 'creates user' do
        
        user_attributes = FactoryGirl.attributes_for :user

        post api_v1_users_path,
          params: {user: user_attributes},
          env: {'HTTP_AUTHORIZATION' => basic_auth(admin_user.username, admin_user.password)}
        
        json = parse_response(response.body)
        expect(json[:username]).to eq(user_attributes[:username])
        expect(json[:password]).to eq(user_attributes[:password])
        expect(json[:name]).to eq(user_attributes[:name])
      end

    end

    context 'normal user' do

      it 'creates user' do
        
        user_attributes = FactoryGirl.attributes_for :user

        post api_v1_users_path,
          params: {user: user_attributes},
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
        
        json = parse_response(response.body)
        expect(json[:username]).to eq(user_attributes[:username])
        expect(json[:password]).to eq(user_attributes[:password])
        expect(json[:name]).to eq(user_attributes[:name])
      end

    end


  end

  describe '#update' do

    context 'admin user' do

      it 'update any user' do
        
        user_attributes = FactoryGirl.attributes_for :user, name: 'updated name'

        put api_v1_user_path(user),
          params: {user: user_attributes},
          env: {'HTTP_AUTHORIZATION' => basic_auth(admin_user.username, admin_user.password)}
        
        json = parse_response(response.body)
        expect(json[:name]).to eq(user_attributes[:name])
      end

    end

    context 'normal user' do

      it 'update own information' do
        
        user_attributes = FactoryGirl.attributes_for :user, name: 'updated name'

        put api_v1_user_path(user),
          params: {user: user_attributes},
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
        json = parse_response(response.body)
        expect(json[:name]).to eq(user_attributes[:name])
      end

      it 'reponses with unauthrization' do
        
        user_attributes = FactoryGirl.attributes_for :user, name: 'updated name'

        put api_v1_user_path(admin_user),
          params: {user: user_attributes},
          env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
        
        json = parse_response(response.body)
        expect(json[:error]).to eq('You are not authorized to access this page.')
      end

    end

  end

  describe '#destroy' do
    context 'admin user' do

      it 'destroy user' do      

        expect {
          delete api_v1_user_path(user),
            env: {'HTTP_AUTHORIZATION' => basic_auth(admin_user.username, admin_user.password)}
        }.to change(User,:count).by(-1)
        expect(response).to be_success

      end

    end

    context 'normal user' do

      it 'destroy user' do      

        expect {
          delete api_v1_user_path(user),
            env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}
        }.to change(User,:count).by(-1)
        expect(response).to be_success

      end

      it 'response with unauthrization access message' do
        
        delete api_v1_user_path(admin_user),
            env: {'HTTP_AUTHORIZATION' => basic_auth(user.username, user.password)}

        json = parse_response(response.body)
        expect(json[:error]).to eq('You are not authorized to access this page.')
        
      end

    end

  end
  
end
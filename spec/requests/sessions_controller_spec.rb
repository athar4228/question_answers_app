require 'rails_helper'

RSpec.describe SessionsController, type: :request do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = stub_omniauth
  end

  context '#GET' do
    context 'auth/:provider/callback' do
      it 'creates user and redirects to questions' do
        get '/auth/google/callback'

        user = assigns(:user)
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(questions_path)
      end
    end

    context 'destroy' do
      it 'sign_outs user and redirects to home page' do
        get '/logout'
        expect(session[:user_id]).to be(nil)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

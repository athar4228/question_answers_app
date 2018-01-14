require 'rails_helper'

RSpec.describe UsersController, type: :request do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = stub_omniauth
    get '/auth/google/callback'
  end

  let!(:user_id) { session[:user_id] }

  context '#GET' do
    context 'my_questions' do

      it 'renders index page' do
        get '/my_questions'

        expect(response).to render_template(:my_questions)
        expect(response.code).to eq('200')
      end
    end

    context 'my_answers' do

      it 'renders index page' do
        get '/my_answers'

        expect(response).to render_template(:my_answers)
        expect(response.code).to eq('200')
      end
    end
  end
end

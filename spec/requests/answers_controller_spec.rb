require 'rails_helper'

RSpec.describe AnswersController, type: :request do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = stub_omniauth
    get '/auth/google/callback'
  end

  let!(:user_id) { session[:user_id] }
  let!(:question) { create(:question) }

  context '#POST' do
    context 'create' do

      it 'redirects to question show page if question is valid after creating answer' do
        post "/questions/#{question.id}/answers", params: { answer: { body: "test2" } }
        expect(response).to redirect_to(question)
        expect(response.code).to eq('302')
        follow_redirect!

        expect(response).to render_template(:show)
      end

      it 'redirects to question show page' do
        post "/questions/#{Faker::Number.number(1)}/answers", params: { answer: { body: "test2" } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

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

  context '#PATCH' do
    context 'update' do

      let(:question) { create(:question, user_id: user_id) }
      let(:answer) { create(:answer, question_id: question.id) }

      it 'returns status 302 if question id is valid' do
        patch "/questions/#{question.id}/answers/#{answer.id}", params: { answer: { body: "test2" } }, xhr: true
        expect(response.code).to eq('302')
      end

      it 'redirects to root page if question id is invalid' do
        patch "/questions/#{question.id}/answers/#{Faker::Number.number(1)}", params: { answer: { body: "test2" } }, xhr: true
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context '#DESTROY' do
    context 'destroy' do

      let(:question) { create(:question) }
      let(:answer) { create(:answer, question_id: question.id) }

      it 'returns status 200 if question is valid' do
        delete "/questions/#{question.id}/answers/#{answer.id}", xhr: true
        expect(response.code).to eq('200')
      end

      it 'redirects to root page if question id is invalid' do
        delete "/questions/#{question.id}/answers/#{Faker::Number.number(1)}", xhr: true
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

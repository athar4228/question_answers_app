require 'rails_helper'

RSpec.describe QuestionsController, type: :request do

  before(:each) do
    Rails.application.env_config["omniauth.auth"] = stub_omniauth
    get '/auth/google/callback'
  end

  let!(:user_id) { session[:user_id] }

  context '#GET' do
    context 'index' do

      it 'renders index page' do
        get '/questions'

        expect(response).to render_template(:index)
        expect(response.code).to eq('200')
      end
    end

    context 'show' do

      let(:question) { create(:question) }

      it 'renders show page' do
        get "/questions/#{question.id}"

        expect(response).to render_template(:show)
        expect(response.code).to eq('200')
      end

      it 'redirects to root page if question id is invalid' do
        get "/questions/#{Faker::Number.number(1)}"
        expect(response).to redirect_to(root_path)
      end
    end

    context 'index' do

      it 'renders index page' do
        get '/questions/search'

        expect(response).to render_template(:index)
        expect(response.code).to eq('200')
      end
    end
  end

  context '#POST' do
    context 'create' do

      it 'redirects to show page' do
        post '/questions', params: { question: { title: "test1", body: "test2" } }
        expect(response).to redirect_to(assigns(:question))
        expect(response.code).to eq('302')
        follow_redirect!

        expect(response).to render_template(:show)
      end
    end
  end

  context '#PATCH' do
    context 'update' do

      let(:question) { create(:question, user_id: user_id) }

      it 'redirects to show page if question id is valid' do
        patch "/questions/#{question.id}", params: { question: { title: "test1", body: "test2" } }
        expect(response).to redirect_to(assigns(:question))
        expect(response.code).to eq('302')
        follow_redirect!

        expect(response).to render_template(:show)
      end

      it 'redirects to root page if question id is invalid' do
        patch "/questions/#{Faker::Number.number(1)}", params: { question: { title: "test1", body: "test2" } }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context '#DESTROY' do
    context 'destroy' do

      let(:question) { create(:question) }

      it 'redirects to show page' do
        delete "/questions/#{question.id}"
        expect(response).to redirect_to(questions_path)
        expect(response.code).to eq('302')
        follow_redirect!

        expect(response).to render_template(:index)
      end

      it 'redirects to root page if question id is invalid' do
        patch "/questions/#{Faker::Number.number(1)}", params: { question: { title: "test1", body: "test2" } }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end

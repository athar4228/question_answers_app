require 'rails_helper'

RSpec.describe PagesController, type: :request do

  context '#GET' do
    context '/' do

      it 'renders home page' do
        get '/'

        expect(response).to render_template(:home)
        expect(response.code).to eq('200')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Question, type: :model do

  subject { create(:question) }

  context '#create' do

    it 'is invalid if title is empty' do
      expect(build(:question, title: nil)).not_to be_valid
    end

    it 'is invalid if title is empty' do
      expect(build(:question, title: Faker::Lorem.sentence(200))).not_to be_valid
    end

    it 'is invalid if body is empty' do
      expect(build(:question, body: nil)).not_to be_valid
    end

    it 'is invalid if user_id is empty' do
      expect(build(:question, user_id: nil)).not_to be_valid
    end

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end

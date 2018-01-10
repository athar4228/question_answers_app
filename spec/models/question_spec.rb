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

  context 'matches passed user to be author for question' do
    it 'returns false if user is not author' do
      user = build(:user)
      expect(subject.has_author?(user)).to be(false)
    end

    it 'returns true if user is author' do
      expect(subject.has_author?(subject.author)).to be(true)
    end
  end
end

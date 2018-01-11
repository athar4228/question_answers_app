require 'rails_helper'

RSpec.describe Answer, type: :model do

  subject { create(:answer) }

  context '#create' do

    it 'is invalid if body is empty' do
      expect(build(:answer, body: nil)).not_to be_valid
    end

    it 'is invalid if question_id is empty' do
      expect(build(:answer, question_id: nil)).not_to be_valid
    end

    it 'is invalid if user_id is empty' do
      expect(build(:answer, user_id: nil)).not_to be_valid
    end

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'matches passed user to be author for answer' do
    it 'returns false if user is not author' do
      user = build(:user)
      expect(subject.has_author?(user)).to be(false)
    end

    it 'returns true if user is author' do
      expect(subject.has_author?(subject.author)).to be(true)
    end
  end
end

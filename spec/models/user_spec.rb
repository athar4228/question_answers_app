require 'rails_helper'

RSpec.describe User, type: :model do

  subject { create(:user) }

  context '#create' do

    it 'is invalid if first_name is empty' do
      expect(build(:user, email: "new_user@qaapp.com", first_name: nil)).not_to be_valid
    end

    it 'is invalid if last_name is empty' do
      expect(build(:user, email: "new_user@qaapp.com", last_name: nil)).not_to be_valid
    end

    it 'is invalid if email is empty' do
      expect(build(:user, email: nil)).not_to be_valid
    end

    it 'is invalid if email is duplicate' do
      expect(build(:user, email: subject.email)).not_to be_valid
    end

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end

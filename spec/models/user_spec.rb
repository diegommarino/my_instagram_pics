require "rails_helper"

RSpec.describe User, type: :model do
  describe "Should Respond" do
    it { should respond_to(:email) }
    it { should respond_to(:name) }
    it { should respond_to(:image) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
    it { should respond_to(:encrypted_password) }
    it { should respond_to(:reset_password_token) }
    it { should respond_to(:reset_password_sent_at) }
    it { should respond_to(:remember_created_at) }
    it { should respond_to(:name) }
    it { should respond_to(:provider) }
    it { should respond_to(:uid) }
    it { should respond_to(:token) }
  end

  describe 'Methods' do
    context '#from_omniauth' do
      it 'creates a new user if it does not exist' do
        auth = {
          'provider' => 'instagram',
          'uid' => '123',
          'info' => {
            'email' => 'asd@asd.com',
            'name' => 'John Doe',
            'image' => ''
          },
          'credentials' => { 'token' => '123' }
        }
        user_count = User.count()
        User.from_omniauth(auth)
        expect(User.count()).to eq (user_count + 1)
      end

      it 'recover the already registered user' do
        user = create :user
        auth = {
          'provider' => user.provider,
          'uid' => user.uid
        }
        user_from_auth = User.from_omniauth(auth)
        expect(user_from_auth).to eq user
      end
    end
  end

  describe "Factory" do
    let(:user) { build(:user) }

    it { expect(user).to be_a User }
    it { expect(user).to be_valid }
  end
end

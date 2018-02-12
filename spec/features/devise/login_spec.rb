require 'rails_helper'

RSpec.describe 'Devise login', type: :feature do
  describe 'Login screen' do
    let(:user) {create :user}

    before do
      visit user_session_path
    end

    it 'Have a link to omniauth login with instagram' do
      expect(page).to have_css("a[href='#{user_instagram_omniauth_authorize_path}']")
    end

    it 'Have a instagram logo' do
      expect(page).to have_css("img[src*='instagram-logo.png'][class='mb-4']")
    end

    it 'Have the system name' do
      expect(page).to have_css("span.h3.mb-3.font-weight-normal", text: "My Instagram Pics")
    end

    it 'Have a info message' do
      expect(page).to have_css("p", text: "Click the icon to login")
    end
  end
end

require 'rails_helper'

RSpec.describe 'Home index', type: :feature do
  describe 'Index after login' do
    describe 'Happy scenarios', :vcr => { :cassette_name => "instagram_api/valid_response"} do

      let(:user) {create :user}

      before do
        sign_in user
        visit root_path
      end

      context 'User can see a navbar' do
        it 'Is fixed top on the page' do
          expect(page).to have_css("nav.navbar.fixed-top.navbar-light.bg-light")
        end

        it 'Have a instagram logo' do
          expect(page).to have_css("img[src*='instagram-logo.png']")
        end

        it 'Have the system name with navbar-brand class' do
          expect(page).to have_css("h1.navbar-brand", text: "My Instagram Pics")
        end

        it 'Have the user name with navbar-brand class' do
          expect(page).to have_css("h1.navbar-brand", text: user.name)
        end

        it 'Have a logout button' do
          expect(page).to have_selector("form[action='#{destroy_user_session_path}'][method='post'][class='button_to']")
          expect(page).to have_selector("input[type=submit][value='Logout'][class='btn btn-secondary']")
        end
      end

      context 'User can see his pictures cards with comments' do
        it 'have at least 1 card' do
          expect(page.all("div.card").count > 0).to be true
        end

        it 'have cards with images' do
          expect(page).to have_css("img.card-img-top")
        end

        it 'have cards with comments' do
          expect(page).to have_css("p.card-text")
        end
      end
    end

    describe 'Alternative scenarios', :vcr => { :cassette_name => "instagram_api/invalid_response"} do
      let(:user) { create :user, token: '' }

      before do
        sign_in user
        visit root_path
      end

      context 'User have a expired token' do
        it 'have no cards' do
          expect(page).to_not have_css("div.card")
        end
      end
    end
  end
end

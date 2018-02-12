require 'rails_helper'

RSpec.describe 'Home Controller Requests', type: :request do
    describe 'GET /index' do
        context 'with valid user token', :vcr => { :cassette_name => "instagram_api/valid_response"} do
            before do
                sign_in create :user
                get root_path, params: {}
            end

            it 'return 200 and template renders the right template.' do
                expect(response).to have_http_status(200)
                expect(response).to render_template(:index)
            end

            it 'renders images urls with comments.' do
                expect(assigns["pics"].size).to_not eq 0
            end
        end

        context 'with invalid user token', :vcr => { :cassette_name => "instagram_api/invalid_response"} do
            before do
                sign_in create :user, token: ""
                get root_path, params: {}
            end

            it 'return 200 and template renders the right template.' do
                expect(response).to have_http_status(200)
                expect(response).to render_template(:index)
            end

            it 'flashes a expired token message.' do
                expect(flash[:warning]).to eq I18n.t 'omniauth_messages.expired_token'
            end
        end
    end
end

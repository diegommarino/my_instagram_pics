FactoryGirl.define do
    factory :user do
        email "test@test2.com"
        password "testtest"
        password_confirmation "testtest"
        name "testtest"
        provider "instagram"
        token "123"
    end
end

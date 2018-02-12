FactoryGirl.define do
    factory :user do
        email "test@test2.com"
        password "testtest"
        password_confirmation "testtest"
        name "testtest"
        provider "instagram"
        token "229766773.7de1c86.b18ce418a79a4cc0afe43ea110e6dc68"
    end
end

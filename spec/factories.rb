FactoryBot.define do
    factory :user do
        email {"amber@vqhomes.com"}
        password {"ruby123"}
        password_confirmation {"ruby123"}
    end

    factory :photo do
        caption { "hello" }
        picture {"test.jpg"}
        association :user
      end
      
end
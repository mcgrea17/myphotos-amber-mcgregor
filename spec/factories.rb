FactoryBot.define do
    factory :user do
        sequence :email do |n|
            "dummyEmail#{n}@gmail.com" 
         end
        
        password {"ruby123"}
        password_confirmation {"ruby123"}
    end

    factory :photo do
        caption { "hello" }
        picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'picture.png').to_s, 'image/png') }
        association :user
        association :location
      end

      factory :location do
        name { "hello" }
      end

      factory :album do;
        name { "Album1" }
        startDate{ "2019-08-08"}
        endDate{ "2019-08-18"}
        association :user
        association :location
      end
      
end
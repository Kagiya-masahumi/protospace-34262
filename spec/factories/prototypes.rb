FactoryBot.define do
  factory :prototype do
    title {Faker::Lorem.sentence}
    catch_copy {Faker::Lorem.sentence}
    concept {Faker::Lorem.sentence}
    image {Faker::Lorem.sentence}

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/sample.png'), filename: 'sample.png')
    end

    association :user 
  end
end
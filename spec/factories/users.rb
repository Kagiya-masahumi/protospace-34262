FactoryBot.define do
  factory :user do
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    name                  {Faker::Name.name}
    profile               {'testtesttest'}
    occupation            {Faker::Job.title}
    position              {Faker::Job.position}
  end
end
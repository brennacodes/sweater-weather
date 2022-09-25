FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { "test" }
    api_key { "jgn983hy48thw9begh98h4539h4" }
  end
end
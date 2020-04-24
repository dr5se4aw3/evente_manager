FactoryBot.define do
  factory :user do
    name {"sample01"}
    email {"sample01@sample.com"}
    password{ 'sample' }
    uid {SecureRandom.uuid}
  end
end

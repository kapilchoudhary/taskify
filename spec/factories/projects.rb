FactoryBot.define do
  factory :project do
    title { "Test project title" }
    description { "this is for testing purpose" }
    start_date { "2022-11-17 15:21:31" }
    end_date { "2022-11-17 15:21:31" }
    status { 1 }
    user_id { 1 }
  end
end

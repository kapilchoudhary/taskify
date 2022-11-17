FactoryBot.define do
  factory :task do
    title { "Test task title" }
    content { "this is for testing purpose" }
    status { 1 }
    reporters_id { 1 }
    assignee_id { 1 }
    project_id { 1 }
  end
end

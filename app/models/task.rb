# frozen_string_literal: true

class Task < ApplicationRecord
  has_rich_text :content
  belongs_to :project
  belongs_to :assignee, foreign_key: :assignee_id, class_name: 'User'
  belongs_to :reporter, foreign_key: :reporters_id, class_name: 'User'

  enum :status, %i[done ready_to_deploy QA in_progress to_do code_review backlog], default: :backlog
end

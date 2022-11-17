# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, presence: true, length: { minimum: 10 }, uniqueness: true
  validates :content, presence: true, length: { minimum: 10 }

  has_rich_text :content
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :project
  belongs_to :assignee, foreign_key: :assignee_id, class_name: 'User'
  belongs_to :reporter, foreign_key: :reporters_id, class_name: 'User'

  enum :status, %i[All done ready_to_deploy QA in_progress to_do
                   code_review backlog], default: :backlog

  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_search, ->(search) { search(search) }

  def self.tasks_filter(filtering_params, user)
    results = user.assigned_tasks
      filtering_params.each do |key, value|
        value = nil if key == 'status' && value == '0'
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
    results
  end

  def self.search(search)
    if search.present?
      attribute = ActiveRecord::Base.connection.quote(search.to_s.downcase)
      attribute = attribute.gsub(' ', '+') + ':*'
      task_ids = []
      title_ids = where(["to_tsvector('english', title) @@ to_tsquery('english', ? )", attribute]).pluck(:id)
      content_ids = where(["to_tsvector('english', content) @@ to_tsquery('english', ? )", attribute]).pluck(:id)
      title_task_ids = where("title LIKE ?", search ).pluck(:id)
      content_task_ids = where("content LIKE ?", search ).pluck(:id)
      task_ids << ((title_task_ids | content_task_ids | title_ids | content_ids).uniq)
      where(id: task_ids.inject(:&))
    else
      all
    end
  end
end

# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, presence: true,
                    length: { minimum: 10 }, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }

  has_rich_text :description
  belongs_to :user
  has_many :tasks

  enum :status, %i[All Published Archived], default: :archived

  scope :filter_by_start_date, ->(start_date) { where('start_date >= :start_date', { start_date: start_date }) }
  scope :filter_by_end_date, ->(end_date) { where('end_date <= :end_date', { end_date: end_date }) }
  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_search, ->(search) { search(search) }

  def self.projects_filter(filtering_params)
    results = Project.where(nil)
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
      project_ids = []
      title_ids = where(["to_tsvector('english', title) @@ to_tsquery('english', ? )", attribute]).pluck(:id)
      description_ids = where(["to_tsvector('english', description) @@ to_tsquery('english', ? )", attribute]).pluck(:id)
      title_project_ids = where("title LIKE ?", search ).pluck(:id)
      description_project_ids = where("description LIKE ?", search ).pluck(:id)
      project_ids << ((title_project_ids | description_project_ids | title_ids | description_ids).uniq)
      where(id: project_ids.inject(:&))
    else
      all
    end
  end
end

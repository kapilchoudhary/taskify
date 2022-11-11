# frozen_string_literal: true

class Project < ApplicationRecord
  # validates :title, presence: true

  has_rich_text :description
  belongs_to :user
  has_many :tasks

  enum :status, %i[published archived], default: :archived
end

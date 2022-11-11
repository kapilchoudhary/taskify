class Project < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  has_many :tasks

  enum :status, [:published, :archived ], default: :archived
end

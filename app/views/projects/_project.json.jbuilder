# frozen_string_literal: true

json.extract! project, :id, :title, :description, :status, :start_date, :created_at, :updated_at
json.url project_url(project, format: :json)
json.description project.description.to_s

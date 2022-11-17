# frozen_string_literal: true

json.extract! task, :id, :title, :content, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
json.content task.content.to_s

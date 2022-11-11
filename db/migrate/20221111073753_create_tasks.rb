# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.integer :status
      t.integer :reporters_id
      t.integer :assignee_id, index: true
      t.integer :project_id, index: true

      t.timestamps
    end
  end
end

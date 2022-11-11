class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :tasks

  has_many :assigned_tasks, foreign_key: :assignee_id, class_name: 'Task' 
  has_many :reported_tasks, foreign_key: :reporters_id, class_name: 'Task'
end

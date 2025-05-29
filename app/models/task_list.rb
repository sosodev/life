class TaskList < ApplicationRecord
  has_many :tasks, dependent: :destroy
end

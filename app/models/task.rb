class Task < ApplicationRecord
  belongs_to :task_list
  belongs_to :parent, class_name: "Task", optional: true
  has_many :children, class_name: "Task", foreign_key: "parent_id", dependent: :destroy

  serialize :estimate, coder: DurationCoder
  serialize :time_taken, coder: DurationCoder
  serialize :recur_after, coder: DurationCoder
end

class Task < ApplicationRecord
  belongs_to :task_list
  belongs_to :parent, class_name: "Task", optional: true
  has_many :children, class_name: "Task", foreign_key: "parent_id", dependent: :destroy

  validates_presence_of :name
  validate :cannot_be_its_own_parent

  serialize :estimate, coder: DurationCoder
  serialize :time_taken, coder: DurationCoder
  serialize :recur_after, coder: DurationCoder

  private

  def cannot_be_its_own_parent
    if parent_id == id
      errors.add(:parent, "cannot be itself")
    end
  end
end

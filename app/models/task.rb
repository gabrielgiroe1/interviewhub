class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :due_date, presence: true
  enum :status, [ pending: "pending", in_progress: "in progress", done: "done" ]

  scope :pending, -> { where(status: :pending) }
  scope :done, -> { where(stauts: :done) }
  scope :overdue, -> { where("due_date < ? AND status != ?", Time.current, :done) }

  def mark_as_completed
    update(status: :done)
  end

  def overdue?
    due_date.present? && due_date < Time.current && status != "done"
  end
end

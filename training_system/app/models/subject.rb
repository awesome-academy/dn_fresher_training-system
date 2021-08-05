class Subject < ApplicationRecord
  has_many :courses, through: :course_subjects
  has_many :course_subjects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks

  validate :at_least_one_subject_task
  validates :name, :description, :duration, presence: true

  private

  def at_least_one_subject_task
    return errors.add :base, t("model.validation_subject") if tasks.blank?
  end
end

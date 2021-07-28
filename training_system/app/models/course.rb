class Course < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  accepts_nested_attributes_for :user_courses, update_only: true
  enum status: {init: 0, in_progress: 1, finished: 2}

  scope :created_desc, ->{order(created_at: :desc)}

  validates :name, :description, :start_date, :end_date, presence: true
  validate :check_start_date_greater_current_date, if: ->{start_date.present?},
                                                   on: :create
  validate :check_end_date_is_after_start_date, if: ->{is_date_present?},
                                                on: :create

  private

  def check_start_date_greater_current_date
    return unless start_date < Time.zone.now

    errors.add(
      :start_date, I18n.t("courses.mess_start_date_error")
    )
  end

  def check_end_date_is_after_start_date
    return unless start_date >= end_date

    errors.add(
      :end_date, I18n.t("courses.mess_start_date_eq_end_date_error")
    )
  end

  def is_date_present?
    end_date.present? && start_date.present?
  end
end

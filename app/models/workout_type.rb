# == Schema Information
#
# Table name: workout_types
#
#  id      :integer          not null, primary key
#  name    :string
#  user_id :integer
#
# Indexes
#
#  index_workout_types_on_user_id  (user_id)
#

class WorkoutType < ActiveRecord::Base
  belongs_to :user
  has_many :workout_exercises, inverse_of: :workout_type, dependent: :destroy
  has_many :exercise_types, through: :workout_exercises
  has_many :workouts, dependent: :destroy

  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

  validates_presence_of :user_id

  class << self
    def allowed_params
      [
        :name,
        workout_exercises_attributes: [
          :exercise_type_id,
          :sets,
          :reps
        ]
      ]
    end
  end

  def to_builder
    Jbuilder.new do |workout_type|
      workout_type.(self, :id, :name)
    end
  end
end

class RaceEntry < ApplicationRecord
  belongs_to :race

  validates :student_name, presence: true, uniqueness: { scope: :race_id, message: "has already been assigned in this race" }

  validates :lane, presence: true,
                   uniqueness: { scope: :race_id, message: "is already taken in this race" },
                   numericality: { only_integer: true, greater_than: 0 }

  validates :final_place, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
end

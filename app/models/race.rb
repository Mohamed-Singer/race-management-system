class Race < ApplicationRecord
  has_many :race_entries, dependent: :destroy
  accepts_nested_attributes_for :race_entries, allow_destroy: true


  validates :name, presence: true

  validate :validate_minimum_race_entries

  private

  def validate_minimum_race_entries
    valid_entries = race_entries.reject(&:marked_for_destruction?)
    if valid_entries.size < 2
      errors.add(:base, "Race must have at least two race entries")
    end
  end
end

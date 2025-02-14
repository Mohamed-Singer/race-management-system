class Race < ApplicationRecord
  has_many :race_entries, dependent: :destroy
  accepts_nested_attributes_for :race_entries, allow_destroy: true


  validates :name, presence: true

  validate :validate_minimum_race_entries
  validate :validate_final_places_consistency

  private

  def validate_minimum_race_entries
    valid_entries = race_entries.reject(&:marked_for_destruction?)
    if valid_entries.size < 2
      errors.add(:base, "Race must have at least two race entries")
    end
  end

  def validate_final_places_consistency
    places = race_entries.map(&:final_place).compact
    return if places.empty?

    expected = 1
    places.tally.sort.each do |place, count|
      unless place == expected
        errors.add(:base, "Final places must be continuous and handle ties correctly")
        return
      end
      expected += count
    end
  end
end

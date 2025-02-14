class Race < ApplicationRecord
  has_many :race_entries, dependent: :destroy
  accepts_nested_attributes_for :race_entries, allow_destroy: true


  validates :name, presence: true

  validate :validate_minimum_race_entries
  validate :validate_final_places_consistency
  validate :validate_unique_lanes_among_entries
  validate :validate_unique_student_names_among_entries

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

  def validate_unique_lanes_among_entries
    lanes = race_entries.reject(&:marked_for_destruction?).map { |entry| entry.lane.to_i }
    if lanes.size != lanes.uniq.size
      errors.add(:base, "Each lane must be unique within a race")
    end
  end

  def validate_unique_student_names_among_entries
    names = race_entries.reject(&:marked_for_destruction?).map do |entry|
      entry.student_name.to_s.strip.downcase
    end

    if names.size != names.uniq.size
      errors.add(:base, "Each student can only be assigned once per race")
    end
  end
end

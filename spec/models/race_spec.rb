require 'rails_helper'

RSpec.describe Race, type: :model do
  describe "destroy dependency" do
    it "destroys associated race entries when a race is deleted" do
      race = Race.create!(
        name: "Test Race",
        race_entries_attributes: [
          { student_name: "Mo", lane: 1 },
          { student_name: "Singer", lane: 2 }
        ]
      )

      expect { race.destroy }.to change(RaceEntry, :count).by(-2)
    end
  end

  describe "validations" do
    it "is invalid without a race name" do
      race = Race.new(name: nil)
      expect(race).not_to be_valid
      expect(race.errors[:name]).to include("can't be blank")
    end

    context "minimum race entries validation" do
      it "is invalid on creation with fewer than two race entries" do
        race = Race.new(
          name: "Test Race",
          race_entries_attributes: [
            { student_name: "Mo", lane: 1 }
          ]
        )
        expect(race).not_to be_valid
        expect(race.errors[:base]).to include("Race must have at least two race entries")
      end

      it "is invalid when updating with nested attributes that mark an entry for destruction" do
        race = Race.create!(
          name: "Test Race",
          race_entries_attributes: [
            { student_name: "Mo", lane: 1 },
            { student_name: "Singer", lane: 2 }
          ]
        )

        race.assign_attributes(
          race_entries_attributes: [
            { id: race.race_entries.first.id, _destroy: "1" }
          ]
        )

        expect(race).not_to be_valid
        expect(race.errors[:base]).to include("Race must have at least two race entries")
      end
    end
  end
end

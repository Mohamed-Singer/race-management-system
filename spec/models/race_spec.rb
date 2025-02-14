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

    context "final places consistency validation" do
      context "when all final places are entered" do
        it "is valid for a simple sequence [1, 2]" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Moe", lane: 2, final_place: 2 }
            ]
          )
          expect(race).to be_valid
        end

        it "is valid for tied entries [1, 1, 3]" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Mohamed", lane: 2, final_place: 1 },
              { student_name: "Singer", lane: 3, final_place: 3 }
            ]
          )
          expect(race).to be_valid
        end

        it "is valid for tied entries in the middle [1, 2, 2, 4]" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Moe", lane: 2, final_place: 2 },
              { student_name: "Mohamed", lane: 3, final_place: 2 },
              { student_name: "Singer", lane: 4, final_place: 4 }
            ]
          )
          expect(race).to be_valid
        end

        it "is invalid for [1, 2, 4] (gap after 2)" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Moe", lane: 2, final_place: 2 },
              { student_name: "Mohamed", lane: 3, final_place: 4 }
            ]
          )
          expect(race).not_to be_valid
          expect(race.errors[:base]).to include("Final places must be continuous and handle ties correctly")
        end

        it "is invalid for [2, 3] (missing 1)" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 2 },
              { student_name: "Moe", lane: 2, final_place: 3 }
            ]
          )
          expect(race).not_to be_valid
          expect(race.errors[:base]).to include("Final places must be continuous and handle ties correctly")
        end

        it "is invalid for [1, 3] (missing 2)" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Moe", lane: 2, final_place: 3 }
            ]
          )
          expect(race).not_to be_valid
          expect(race.errors[:base]).to include("Final places must be continuous and handle ties correctly")
        end
      end

      context "when final places are partially entered" do
        it "is valid if no final places have been entered" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1 },
              { student_name: "Moe", lane: 2 }
            ]
          )
          expect(race).to be_valid
        end

        it "ignores nil values and validates the present ones when valid" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Mohamed", lane: 2, final_place: nil },
              { student_name: "Singer", lane: 3, final_place: 2 }
            ]
          )
          expect(race).to be_valid
        end

        it "is invalid if present final places form an invalid sequence even with nils" do
          race = Race.new(
            name: "Test Race",
            race_entries_attributes: [
              { student_name: "Mo", lane: 1, final_place: 1 },
              { student_name: "Mohamed", lane: 2, final_place: nil },
              { student_name: "Singer", lane: 3, final_place: 3 }
            ]
          )
          expect(race).not_to be_valid
          expect(race.errors[:base]).to include("Final places must be continuous and handle ties correctly")
        end
      end
    end
  end
end

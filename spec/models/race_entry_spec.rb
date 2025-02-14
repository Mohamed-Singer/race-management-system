require 'rails_helper'

RSpec.describe RaceEntry, type: :model do
  describe "validations" do
    let(:race) do
      Race.create!(
        name: "100m Sprint",
        race_entries_attributes: [
          { student_name: "One", lane: 3 },
          { student_name: "Two", lane: 4 }
        ]
      )
    end

    context "student_name" do
      it "validates presence of student_name" do
        entry = race.race_entries.build(student_name: nil, lane: 1)
        expect(entry).not_to be_valid
        expect(entry.errors[:student_name]).to include("can't be blank")
      end

      it "validates uniqueness of student_name per race" do
        race.race_entries.create!(student_name: "Mo", lane: 1)
        duplicate = race.race_entries.build(student_name: "Mo", lane: 2)
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:student_name]).to include("has already been assigned in this race")
      end
    end

    context "lane" do
      it "validates presence of lane" do
        entry = race.race_entries.build(student_name: "Mo", lane: nil)
        expect(entry).not_to be_valid
        expect(entry.errors[:lane]).to include("can't be blank")
      end

      it "validates uniqueness of lane per race" do
        race.race_entries.create!(student_name: "Mo", lane: 1)
        duplicate = race.race_entries.build(student_name: "Singer", lane: 1)
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:lane]).to include("is already taken in this race")
      end

      it "validates lane as a positive integer" do
        entry = race.race_entries.build(student_name: "Mo", lane: "first")
        expect(entry).not_to be_valid
        expect(entry.errors[:lane]).to include("is not a number")
      end
    end

    context "final_place" do
      it "allows nil final_place" do
        entry = race.race_entries.build(student_name: "Mo", lane: 1)
        entry.final_place = nil
        expect(entry).to be_valid
      end

      it "validates final_place as a positive integer if provided" do
        entry = race.race_entries.build(student_name: "Mo", lane: 1)
        entry.final_place = 0
        expect(entry).not_to be_valid
        expect(entry.errors[:final_place]).to include("must be greater than 0")
      end
    end
  end
end

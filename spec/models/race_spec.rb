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
  end
end

require 'rails_helper'

RSpec.describe Race, type: :model do
  describe "validations" do
    it "is invalid without a race name" do
      race = Race.new(name: nil)
      expect(race).not_to be_valid
      expect(race.errors[:name]).to include("can't be blank")
    end
  end
end

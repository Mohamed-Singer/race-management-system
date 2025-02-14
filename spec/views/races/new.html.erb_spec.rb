require 'rails_helper'

RSpec.describe "races/new", type: :view do
  before do
    assign(:race, Race.new.tap do |r|
      r.race_entries.build
      r.race_entries.build
    end)
    render
  end

  it "renders the new race form" do
    expect(rendered).to have_content("New Race")
    expect(rendered).to have_selector("form")
    expect(rendered).to have_field("Race Name")
  end

  it "renders error messages partial when race has errors" do
    race = Race.new
    race.errors.add(:name, "cannot be blank")
    assign(:race, race)
    render
    expect(rendered).to have_selector("div.alert.alert-danger")
    expect(rendered).to match(/cannot be blank/)
  end

  it "shows an 'Add another student' button" do
    expect(rendered).to have_link("Add another student")
  end
end

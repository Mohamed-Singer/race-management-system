require 'rails_helper'

RSpec.describe "races/edit", type: :view do
  before do
    @race = assign(:race, Race.create!(name: "Test Race", race_entries_attributes: [
      { student_name: "Mo", lane: 1, final_place: 1 },
      { student_name: "Singer", lane: 2, final_place: 2 }
    ]))
    render
  end

  it "renders the edit form" do
    expect(rendered).to have_content("Edit Race")
    expect(rendered).to have_selector("form")
    expect(rendered).to have_field("Final Place")
  end

  it "has navigation links for Home and Back" do
    expect(rendered).to have_link("Back", href: race_path(@race))
  end
end

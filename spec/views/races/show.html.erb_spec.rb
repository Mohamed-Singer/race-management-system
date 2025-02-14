require 'rails_helper'

RSpec.describe "races/show", type: :view do
  before do
    @race = assign(:race, Race.create!(name: "Test Race", race_entries_attributes: [
      { student_name: "Mo", lane: 1 },
      { student_name: "Singer", lane: 2 }
    ]))
    render
  end

  it "displays the race name" do
    expect(rendered).to match(/Test Race/)
  end

  it "displays race entries" do
    expect(rendered).to match(/Mo/)
    expect(rendered).to match(/Singer/)
  end

  it "has navigation links for Home and Back" do
    expect(rendered).to have_link("Back", href: races_path)
  end
end

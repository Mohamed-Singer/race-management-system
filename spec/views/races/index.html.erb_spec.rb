require 'rails_helper'

RSpec.describe "races/index", type: :view do
  before do
    assign(:races, [
      Race.create!(name: "Race One", race_entries_attributes: [
        { student_name: "Mo", lane: 1 },
        { student_name: "Singer", lane: 2 }
      ]),
      Race.create!(name: "Race Two", race_entries_attributes: [
        { student_name: "Moe", lane: 1 },
        { student_name: "Mohamed", lane: 2 }
      ])
    ])
    render
  end

  it "displays the list of races" do
    expect(rendered).to match(/Race One/)
    expect(rendered).to match(/Race Two/)
  end

  it "includes navigation links" do
    expect(rendered).to have_link("Create New Race", href: new_race_path)
  end
end

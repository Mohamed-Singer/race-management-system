require 'rails_helper'

RSpec.describe "Races", type: :request do
  describe "GET /races" do
    before do
      Race.create!(name: "Race One", race_entries_attributes: [
        { student_name: "Mo", lane: 1 },
        { student_name: "Singer", lane: 2 }
      ])
      Race.create!(name: "Race Two", race_entries_attributes: [
        { student_name: "Moe", lane: 1 },
        { student_name: "Mohamed", lane: 2 }
      ])
    end

    it "renders the index page with a list of races" do
      get races_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Create New Race")
      expect(response.body).to include("Race One")
      expect(response.body).to include("Race Two")
    end
  end

  describe "GET /races/new" do
    it "renders the new race form" do
      get new_race_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("New Race")
      expect(response.body).to include("Race Name")
    end
  end

  describe "POST /races" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          race: {
            name: "100m Dash",
            race_entries_attributes: {
              "0" => { student_name: "Mo", lane: 1 },
              "1" => { student_name: "Singer", lane: 2 }
            }
          }
        }
      end

      it "creates a new race and redirects to its show page" do
        expect {
          post races_path, params: valid_params
        }.to change(Race, :count).by(1)
        expect(response).to redirect_to(race_path(Race.last))
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          race: {
            name: "Test",
            race_entries_attributes: {
              "0" => { student_name: "Mo", lane: 1 },
              "1" => { student_name: "Singer", lane: 1 }
            }
          }
        }
      end

      it "renders the new template with errors" do
        post races_path, params: invalid_params
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("error")
      end
    end
  end

  describe "GET /races/:id" do
    let!(:race) do
      Race.create!(name: "Test Race", race_entries_attributes: [
        { student_name: "Mo", lane: 1 },
        { student_name: "Singer", lane: 2 }
      ])
    end

    it "renders the show page" do
      get race_path(race)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(race.name)
      expect(response.body).to include("Mo")
      expect(response.body).to include("Singer")
    end
  end

  describe "GET /races/:id/edit" do
    let!(:race) do
      Race.create!(name: "Test Race", race_entries_attributes: [
        { student_name: "Mo", lane: 1, final_place: nil },
        { student_name: "Singer", lane: 2, final_place: nil }
      ])
    end

    it "renders the edit form" do
      get edit_race_path(race)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit Race")
      expect(response.body).to include("Final Place")
    end
  end

  describe "PATCH /races/:id" do
    let!(:race) do
      Race.create!(name: "Test Race", race_entries_attributes: [
        { student_name: "Mo", lane: 1 },
        { student_name: "Singer", lane: 2 }
      ])
    end

    context "with valid update parameters" do
      let(:update_params) do
        {
          race: {
            name: "Test Race",
            race_entries_attributes: {
              "0" => { id: race.race_entries.first.id, student_name: "Mo", lane: 1, final_place: 1 },
              "1" => { id: race.race_entries.second.id, student_name: "Singer", lane: 2, final_place: 2 }
            }
          }
        }
      end

      it "updates the race and redirects to show" do
        patch race_path(race), params: update_params
        expect(response).to redirect_to(race_path(race))
        follow_redirect!
        expect(response.body).to include("Race updated successfully")
      end
    end

    context "with invalid update parameters" do
      let(:invalid_update_params) do
        {
          race: {
            name: "Test Race",
            race_entries_attributes: {
              "0" => { id: race.race_entries.first.id, student_name: "Mo", lane: 1, final_place: 1 },
              "1" => { id: race.race_entries.second.id, student_name: "Singer", lane: 2, final_place: 4 }
            }
          }
        }
      end

      it "renders the edit template with errors" do
        patch race_path(race), params: invalid_update_params
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("error")
      end
    end
  end

  describe "DELETE /races/:id" do
    let!(:race) do
      Race.create!(name: "Race to Delete", race_entries_attributes: [
        { student_name: "Mo", lane: 1 },
        { student_name: "Singer", lane: 2 }
      ])
    end

    it "deletes the race and redirects to index" do
      expect {
        delete race_path(race)
      }.to change(Race, :count).by(-1)
      expect(response).to redirect_to(races_path)
    end
  end
end

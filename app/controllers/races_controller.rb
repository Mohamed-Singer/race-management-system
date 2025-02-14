class RacesController < ApplicationController
  before_action :set_race, only: [ :show, :edit, :update, :destroy ]

  def index
    @races = Race.all
  end

  def show
  end

  def new
    @race = Race.new

    2.times { @race.race_entries.build }
  end

  def create
    @race = Race.new(race_params)
    if @race.save
      redirect_to @race, notice: "Race created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @race.update(race_params)
      redirect_to @race, notice: "Race updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @race.destroy
    redirect_to races_path, notice: "Race deleted successfully."
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def race_params
    params.require(:race).permit(
      :name,
      race_entries_attributes: [ :id, :student_name, :lane, :final_place, :_destroy ]
    )
  end
end

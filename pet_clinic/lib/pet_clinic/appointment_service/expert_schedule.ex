defmodule PetClinic.AppointmentService.ExpertSchedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_schedules" do
    field :monday_start, :time
    field :monday_end, :time
    field :tuesday_start, :time
    field :tuesday_end, :time
    field :wednesday_start, :time
    field :wednesday_end, :time
    field :thursday_start, :time
    field :thursday_end, :time
    field :friday_start, :time
    field :friday_end, :time
    field :saturday_start, :time
    field :saturday_end, :time
    field :sunday_start, :time
    field :sunday_end, :time
    field :week_start, :date
    field :week_end, :date

    belongs_to :expert, PetClinic.PetHealthExpert.Expert

    timestamps()
  end

  @doc false
  def changeset(expert_schedule, attrs) do
    expert_schedule
    |> cast(attrs, [])
    |> validate_required([])
  end
end

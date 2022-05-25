defmodule PetClinic.AppointmentService.ExpertSchedule do
  @moduledoc """
  defines the schema/model of the schedule
  that each health expert has each week
  """
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
    |> cast(attrs, [
      :monday_start,
      :monday_end,
      :tuesday_start,
      :tuesday_end,
      :wednesday_start,
      :wednesday_end,
      :thursday_start,
      :thursday_end,
      :friday_start,
      :friday_end,
      :saturday_start,
      :saturday_end,
      :sunday_start,
      :sunday_end,
      :week_start,
      :week_end,
      :expert_id
    ])
    |> validate_required([
      :monday_start,
      :monday_end,
      :tuesday_start,
      :tuesday_end,
      :wednesday_start,
      :wednesday_end,
      :thursday_start,
      :thursday_end,
      :friday_start,
      :friday_end,
      :saturday_start,
      :saturday_end,
      :sunday_start,
      :sunday_end,
      :week_start,
      :week_end,
      :expert_id
    ])

    # |> unique_constraint([:expert_id])
    # |> foreign_key_constraint(:expert_id)
  end
end

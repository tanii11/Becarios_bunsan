defmodule PetClinic.PetHealthExpert.Expert do
  @moduledoc """
  defines the schema/model of the health expert that the clinic can have at its service
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]

    has_many :pets, PetClinic.PetClinicService.Pet
    many_to_many :specialities, PetClinic.PetType, join_through: PetClinic.ExpertSpecialities

    has_many :appoiments, PetClinic.Appointment
    has_one :expert_schedules, PetClinic.AppointmentService.ExpertSchedule

    timestamps()
  end

  @doc false
  def changeset(expert, attrs) do
    expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end

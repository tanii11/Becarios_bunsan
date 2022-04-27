defmodule PetClinic.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :datetime, :utc_datetime

    belongs_to :pet, PetClinic.PetClinicService.Pet
    belongs_to :expert, PetClinic.PetHealthExpert.Expert

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [])
    |> validate_required([])
  end
end

defmodule PetClinic.Appointment do
  @moduledoc """
  defines the schema/model of the specialties that a health expert can have
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :datetime, :utc_datetime

    belongs_to :pet, PetClinic.PetClinicService.Pet
    belongs_to :expert, PetClinic.PetHealthExpert.Expert

    timestamps()
  end

  @doc false
  # def changeset(appointment, attrs) do
  #   appointment
  #   |> cast(attrs, [:pet_id, :expert_id])
  #   |> validate_required([:pet_id, :expert_id])
  # end
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:pet_id, :expert_id, :datetime])
    |> validate_required([:pet_id, :expert_id, :datetime])
    |> unique_constraint([:pet_id, :expert_id, :datetime])
    |> foreign_key_constraint(:pet_id)
    |> foreign_key_constraint(:expert_id)
  end
end

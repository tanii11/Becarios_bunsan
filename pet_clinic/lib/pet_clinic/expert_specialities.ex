defmodule PetClinic.ExpertSpecialities do
  @moduledoc """
  defines the schema/model of the specialties that a health expert can have
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_specialities" do
    belongs_to :expert, PetClinic.PetHealthExpert.Expert
    belongs_to :pet_type, PetClinic.PetType

    timestamps()
  end

  @doc false
  def changeset(expert_specialities, attrs) do
    expert_specialities
    |> cast(attrs, [])
    |> validate_required([])
  end
end

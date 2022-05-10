defmodule PetClinic.PetClinicService.Pet do
  @moduledoc """
  defines the schema/model of a pet that can arrive at the clinic
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    #field :type, :string
    belongs_to :type, PetClinic.PetType

    belongs_to :owner, PetClinic.PetOwner.Owner
    belongs_to :expert, PetClinic.PetHealthExpert.Expert

    has_many :appoiments, PetClinic.Appointment

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :age, :type_id, :sex, :owner_id, :expert_id])
    |> validate_required([:name, :age, :type_id, :sex, :owner_id, :expert_id])
    |> validate_inclusion(:age, 0..99)
  end
end

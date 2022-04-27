defmodule PetClinic.PetClinicService.Pet do
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
    |> cast(attrs, [:name, :age, :type, :sex])
    |> validate_required([:name, :age, :type, :sex])
    |> validate_inclusion(:age, 0..99)
  end
end

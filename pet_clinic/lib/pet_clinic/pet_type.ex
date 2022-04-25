defmodule PetClinic.PetType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pet_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(pet_type, attrs) do
    pet_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

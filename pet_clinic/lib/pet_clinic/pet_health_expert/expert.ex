defmodule PetClinic.PetHealthExpert.Expert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, :string
    field :specialities, :string

    timestamps()
  end

  @doc false
  def changeset(expert, attrs) do
    expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end

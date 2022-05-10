defmodule PetClinic.Repo.Migrations.CreatePetTypes do
  use Ecto.Migration
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetType
  import Ecto.Query

  def change do
    create table(:pet_types) do
      add :name, :string

      timestamps()
    end

    query = "select id, type from pets"
    pets = Ecto.Adapters.SQL.query!(Repo, query, []) |> Map.get(:rows)

    query = "select distinct type from pets"
    types = Ecto.Adapters.SQL.query!(Repo, query, []) |> Map.get(:rows) |> List.flatten()

    flush()

    Enum.each(types, fn t ->
      Repo.insert(%PetType{name: t})
    end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()

    IO.inspect(pets)

    Enum.each(pets, fn [pet_id, pet_type] ->
      %PetType{id: pet_type_id} = Repo.get_by(PetType, name: pet_type)
      update = "update pets set type_id = $1::integer where id = $2::integer"
      Ecto.Adapters.SQL.query!(Repo, update, [pet_type_id, pet_id])
    end)
  end
end

defmodule PetClinic.Repo.Migrations.ExpertSpecialitiesToCatalog do
  use Ecto.Migration
  alias PetClinic.Repo
  alias PetClinic.ExpertSpecialities
  import Ecto.Query

  def change do
    create table("expert_specialities") do
      add :expert_id, references("experts")
      add :pet_type_id, references("pet_types")

      timestamps()
    end

    query = "select id, specialities from experts"
    experts = Ecto.Adapters.SQL.query!(Repo, query, []) |> Map.get(:rows)

    flush()

    Enum.map(experts, fn [id, sps] ->
      sps
      |> String.split(",")
      |> Enum.map(fn sp ->
        sp2 = String.trim(sp)
        sp_id = from(s in "pet_types", where: s.name == ^sp2, select: s.id) |> Repo.one!()
        Repo.insert(%ExpertSpecialities{expert_id: id, pet_type_id: sp_id})
      end)
    end)

    alter table("experts") do
      remove :specialities
    end
  end
end

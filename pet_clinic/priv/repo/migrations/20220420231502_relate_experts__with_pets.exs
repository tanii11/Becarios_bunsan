defmodule PetClinic.Repo.Migrations.RelateExpertsWithPets do
  use Ecto.Migration

  def change do
    alter table ("pets") do
      add :expert_id, references("experts")
    end
  end
end

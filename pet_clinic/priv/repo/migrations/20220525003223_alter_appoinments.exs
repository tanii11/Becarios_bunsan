defmodule PetClinic.Repo.Migrations.AlterAppoinments do
  use Ecto.Migration

  def change do
    create unique_index(:appointments, [:pet_id, :expert_id, :datetime])
  end
end

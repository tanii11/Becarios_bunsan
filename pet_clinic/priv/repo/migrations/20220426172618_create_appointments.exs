defmodule PetClinic.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :datetime, :utc_datetime

      add :pet_id, references("pets")
      add :expert_id, references("experts")
      timestamps()
    end
  end
end

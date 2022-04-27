defmodule PetClinic.Repo.Migrations.CreateExpertSchedules do
  use Ecto.Migration

  def change do
    create table(:expert_schedules) do
      add :monday_start, :time
      add :monday_end, :time
      add :tuesday_start, :time
      add :tuesday_end, :time
      add :wednesday_start, :time
      add :wednesday_end, :time
      add :thursday_start, :time
      add :thursday_end, :time
      add :friday_start, :time
      add :friday_end, :time
      add :saturday_start, :time
      add :saturday_end, :time
      add :sunday_start, :time
      add :sunday_end, :time
      add :week_start, :date
      add :week_end, :date

      add :expert_id, references("experts")

      timestamps()
    end
  end
end

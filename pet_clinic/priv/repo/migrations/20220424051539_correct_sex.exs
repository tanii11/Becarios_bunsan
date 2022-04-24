defmodule PetClinic.Repo.Migrations.CorrectSex do
  use Ecto.Migration
  alias PetClinic.Repo

  def change do
    queryP = "update pets set sex = lower(sex)"
    Ecto.Adapters.SQL.query!(Repo, queryP, [])

    queryP = "update pets set sex = 'female' where sex not in ('female', 'male')"
    Ecto.Adapters.SQL.query!(Repo, queryP, [])

    queryE = "update experts set sex = lower(sex)"
    Ecto.Adapters.SQL.query!(Repo, queryE, [])

    queryE = "update experts set sex = 'female' where sex not in ('female', 'male')"
    Ecto.Adapters.SQL.query!(Repo, queryE, [])
  end
end

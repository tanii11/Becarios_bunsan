defmodule PetClinic.PetHealthExpert.Expert do
  @moduledoc """
  defines the schema/model of the health expert that the clinic can have at its service
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias PetClinic.Repo

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]

    has_many :pets, PetClinic.PetClinicService.Pet

    many_to_many :specialities, PetClinic.PetType,
      join_through: PetClinic.ExpertSpecialities,
      on_replace: :delete

    has_many :appoiments, PetClinic.Appointment
    has_one :expert_schedules, PetClinic.AppointmentService.ExpertSchedule

    timestamps()
  end

  @doc false

  def changeset(expert, %{"specialities" => specialitites} = attrs) do
    expert
    |> cast(attrs, [:name, :age, :email, :sex])
    |> validate_required([:name, :age, :email, :sex])
    |> put_assoc(:specialities, enum_association(specialitites, PetClinic.PetType))
  end

  def changeset(expert, attrs) do
    expert
    |> cast(attrs, [:name, :age, :email, :sex])
    |> validate_required([:name, :age, :email, :sex])
  end

  defp enum_association(ids, module) do
    ids =
      Enum.filter(ids, fn id ->
        id != nil
      end)

    ids = Enum.uniq(ids)

    ids =
      Enum.filter(ids, fn id ->
        Repo.get(module, id) != nil
      end)

    Enum.map(ids, fn id ->
      Repo.get(module, id)
    end)
  end
end

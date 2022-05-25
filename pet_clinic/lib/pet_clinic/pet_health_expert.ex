defmodule PetClinic.PetHealthExpert do
  @moduledoc """
  The PetHealthExpert context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo

  alias PetClinic.PetHealthExpert.Expert
  alias PetClinic.ExpertSpecialities
  alias PetClinic.PetType

  @doc """
  Returns the list of experts.

  ## Examples

      iex> list_experts()
      [%Expert{}, ...]

  """
  def list_experts do
    Repo.all(Expert) |> Repo.preload(:specialities)
  end

  @doc """
  Gets a single expert.

  Raises `Ecto.NoResultsError` if the Expert does not exist.

  ## Examples

      iex> get_expert!(123)
      %Expert{}

      iex> get_expert!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert!(id) do
    Repo.get!(Expert, id) |> Repo.preload(:specialities)
  end

  @doc """
  Creates a expert.

  ## Examples

      iex> create_expert(%{field: value})
      {:ok, %Expert{}}

      iex> create_expert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert(attrs \\ %{}) do
    %Expert{}
    |> Expert.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert.

  ## Examples

      iex> update_expert(expert, %{field: new_value})
      {:ok, %Expert{}}

      iex> update_expert(expert, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert(%Expert{} = expert, attrs) do
    expert
    |> Expert.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert.

  ## Examples

      iex> delete_expert(expert)
      {:ok, %Expert{}}

      iex> delete_expert(expert)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert(%Expert{} = expert) do
    Repo.delete(expert)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert changes.

  ## Examples

      iex> change_expert(expert)
      %Ecto.Changeset{data: %Expert{}}

  """
  def change_expert(%Expert{} = expert, attrs \\ %{}) do
    Expert.changeset(expert, attrs)
  end

  @spec list_specialities(any) :: list
  def list_specialities(id) do
    nose =
      Repo.all(from a in ExpertSpecialities, where: a.expert_id == ^id, select: a.pet_type_id)

    Enum.map(nose, fn x -> Repo.all(from p in PetType, where: p.id == ^x) end) |> List.flatten()
  end
end

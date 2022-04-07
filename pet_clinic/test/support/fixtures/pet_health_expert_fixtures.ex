defmodule PetClinic.PetHealthExpertFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetHealthExpert` context.
  """

  @doc """
  Generate a expert.
  """
  def expert_fixture(attrs \\ %{}) do
    {:ok, expert} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: "some sex",
        specialities: "some specialities"
      })
      |> PetClinic.PetHealthExpert.create_expert()

    expert
  end
end

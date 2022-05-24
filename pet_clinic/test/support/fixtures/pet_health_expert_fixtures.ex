defmodule PetClinic.PetHealthExpertFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetHealthExpert` context.
  """

  @doc """
  Generate a expert.
  """
  # def expert_fixture(attrs \\ %{}) do
  #   {:ok, expert} =
  #     attrs
  #     |> Enum.into(%{
  #       age: 42,
  #       email: "some email",
  #       name: "some name",
  #       sex: "female",
  #       specialities: "some specialities"
  #     })
  #     |> PetClinic.PetHealthExpert.create_expert()

  #   expert
  # end

  import PetClinic.Factory


  def experts_fixture(attrs \\ %{}) do

    %{
      expert_0:
        insert(:expert,
          age: 42,
          email: "some email",
          name: "some name",
          sex: "female"
        ),
      expert_1:
      insert(:expert,
        age: 43,
        email: "some update email",
        name: "some update name",
        sex: "female"
      )
    }
  end
end

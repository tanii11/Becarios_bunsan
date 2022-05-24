defmodule PetClinic.PetOwnerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetOwner` context.
  """

  @doc """
  Generate a owner.
  """
  # def owner_fixture(attrs \\ %{}) do
  #   {:ok, owner} =
  #     attrs
  #     |> Enum.into(%{
  #       age: 42,
  #       email: "some email",
  #       name: "some name",
  #       phone_num: "some phone_num"
  #     })
  #     |> PetClinic.PetOwner.create_owner()

  #   owner
  # end

  import PetClinic.Factory

  def owners_fixture(attrs \\ %{}) do

    %{
      owner_0:
        insert(:owner,
          age: 42,
          email: "some email",
          name: "some name",
          phone_num: "some phone_num"
        ),
      owner_1:
        insert(:owner,
        age: 43,
        email: "some update email",
        name: "some update name",
        phone_num: "some update phone_num"
        )
    }
  end
end

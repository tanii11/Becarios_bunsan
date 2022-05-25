defmodule PetClinic.PetTypeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicService` context.
  """

  @doc """
  Generate a pet.
  """

  import PetClinic.Factory

  def pet_types_fixture(attrs \\ %{}) do
    %{
      pet_type_0:
        insert(:pet_type,
          name: "some name"
        ),
      pet_type_1:
        insert(:pet_type,
          name: "some update name"
        )
    }
  end
end

defmodule PetClinic.PetClinicServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicService` context.
  """

  @doc """
  Generate a pet.
  """

  # def pet_fixture(attrs \\ %{}) do
  #   owner = PetClinic.PetOwnerFixtures.owner_fixture()
  #   expert = PetClinic.PetHealthExpertFixtures.expert_fixture()
  #   {:ok, pet} =
  #     attrs
  #     |> Enum.into(%{
  #       age: 42,
  #       name: "some name",
  #       sex: "female",
  #       type_id: 1,
  #       owner_id: owner.id,
  #       expert_id: expert.id
  #     })
  #     |> PetClinic.PetClinicService.create_pet()

  #   pet
  # end

  import PetClinic.Factory

  def pets_fixture(attrs \\ %{}) do
    owner = attrs.owner_0
    expert = attrs.expert_0
    pet_type = attrs.pet_type_0

    %{
      pet_0:
        insert(:pet,
          age: 42,
          name: "some name",
          sex: "female",
          type_id: pet_type.id,
          owner_id: owner.id,
          expert_id: expert.id
        ),
      pet_1:
        insert(:pet,
          age: 43,
          name: "some update name",
          sex: "female",
          type_id: pet_type.id,
          owner_id: owner.id,
          expert_id: expert.id
        )
    }
  end
end

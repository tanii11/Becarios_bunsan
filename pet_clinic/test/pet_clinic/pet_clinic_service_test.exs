defmodule PetClinic.PetClinicServiceTest do
  use PetClinic.DataCase
  alias PetClinic.PetClinicService
  alias PetClinic.PetClinicService.Pet
  import PetClinic.PetClinicServiceFixtures
  import PetClinic.PetHealthExpertFixtures
  import PetClinic.PetOwnerFixtures
  import PetClinic.PetTypeFixtures

  describe "pets" do
    setup [:owners_fixture, :experts_fixture, :pet_types_fixture, :pets_fixture]

    @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil, type_id: nil, expert_id: nil, owner_id: nil}
    @tag :pet
    test "list_pets/0 returns all pets", %{pet_0: pet, pet_1: pet_1} do
      #pet = pets_fixture()
      assert PetClinicService.list_pets() == [pet, pet_1] |> Repo.preload(:type)
    end

    test "get_pet!/1 returns the pet with given id", %{pet_0: pet} do
      #pet = pets_fixture()
      assert PetClinicService.get_pet!(pet.id) == pet |> Repo.preload(:type)
    end

    test "create_pet/1 with valid data creates a pet" , context do
      valid_attrs = params_for(:pet,
                                age: context.pet_0.age,
                                name: context.pet_0.name,
                                sex: context.pet_0.sex,
                                type_id: context.pet_type_0.id,
                                owner_id: context.owner_0.id,
                                expert_id: context.expert_0.id)

      assert {:ok, %Pet{} = pet} = PetClinicService.create_pet(valid_attrs)

      assert pet.age == context.pet_0.age
      assert pet.name == context.pet_0.name
      assert pet.sex ==  context.pet_0.sex
      assert pet.type_id == context.pet_type_0.id
      assert pet.owner_id == context.owner_0.id
      assert pet.expert_id == context.expert_0.id
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicService.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet", %{pet_0: pet} = context do
      #pet = pets_fixture()

      update_attrs = params_for(:pet,
                                age: context.pet_1.age,
                                name: context.pet_1.name,
                                sex: context.pet_1.sex,
                                type_id: context.pet_type_1.id,
                                owner_id: context.owner_1.id,
                                expert_id: context.expert_1.id)

      assert {:ok, %Pet{} = pet} = PetClinicService.update_pet(pet, update_attrs)

      assert pet.age == context.pet_1.age
      assert pet.name == context.pet_1.name
      assert pet.sex ==  context.pet_1.sex
      assert pet.type_id == context.pet_type_1.id
      assert pet.owner_id == context.owner_1.id
      assert pet.expert_id == context.expert_1.id
    end

    @tag :pet
    test "update_pet/2 with invalid data returns error changeset", %{pet_0: pet} do
      #pet = pets_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicService.update_pet(pet, @invalid_attrs)
      assert pet |> Repo.preload(:type)  == PetClinicService.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet", %{pet_0: pet} do
      #pet = pets_fixture(),
      assert {:ok, %Pet{}} = PetClinicService.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetClinicService.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset", %{pet_0: pet} do
      #pet = pets_fixture()
      assert %Ecto.Changeset{} = PetClinicService.change_pet(pet)
    end
  end
end

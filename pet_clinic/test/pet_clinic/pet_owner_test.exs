defmodule PetClinic.PetOwnerTest do
  use PetClinic.DataCase

  alias PetClinic.PetOwner

  describe "owners" do
    alias PetClinic.PetOwner.Owner

    import PetClinic.PetOwnerFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, phone_num: nil}

    test "list_owners/0 returns all owners" do
      owner = owner_fixture()
      assert PetOwner.list_owners() == [owner]
    end

    test "get_owner!/1 returns the owner with given id" do
      owner = owner_fixture()
      assert PetOwner.get_owner!(owner.id) == owner
    end

    test "create_owner/1 with valid data creates a owner" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", phone_num: "some phone_num"}

      assert {:ok, %Owner{} = owner} = PetOwner.create_owner(valid_attrs)
      assert owner.age == 42
      assert owner.email == "some email"
      assert owner.name == "some name"
      assert owner.phone_num == "some phone_num"
    end

    test "create_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetOwner.create_owner(@invalid_attrs)
    end

    test "update_owner/2 with valid data updates the owner" do
      owner = owner_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", phone_num: "some updated phone_num"}

      assert {:ok, %Owner{} = owner} = PetOwner.update_owner(owner, update_attrs)
      assert owner.age == 43
      assert owner.email == "some updated email"
      assert owner.name == "some updated name"
      assert owner.phone_num == "some updated phone_num"
    end

    test "update_owner/2 with invalid data returns error changeset" do
      owner = owner_fixture()
      assert {:error, %Ecto.Changeset{}} = PetOwner.update_owner(owner, @invalid_attrs)
      assert owner == PetOwner.get_owner!(owner.id)
    end

    test "delete_owner/1 deletes the owner" do
      owner = owner_fixture()
      assert {:ok, %Owner{}} = PetOwner.delete_owner(owner)
      assert_raise Ecto.NoResultsError, fn -> PetOwner.get_owner!(owner.id) end
    end

    test "change_owner/1 returns a owner changeset" do
      owner = owner_fixture()
      assert %Ecto.Changeset{} = PetOwner.change_owner(owner)
    end
  end
end

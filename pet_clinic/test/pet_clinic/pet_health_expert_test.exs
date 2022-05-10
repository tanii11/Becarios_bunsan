defmodule PetClinic.PetHealthExpertTest do
  use PetClinic.DataCase

  alias PetClinic.PetHealthExpert

  describe "experts" do
    alias PetClinic.PetHealthExpert.Expert

    import PetClinic.PetHealthExpertFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

    test "list_experts/0 returns all experts" do
      expert = expert_fixture()
      assert PetHealthExpert.list_experts() == [expert]
    end

    test "get_expert!/1 returns the expert with given id" do
      expert = expert_fixture()
      assert PetHealthExpert.get_expert!(expert.id) == expert
    end

    test "create_expert/1 with valid data creates a expert" do
      valid_attrs = %{
        age: 42,
        email: "some email",
        name: "some name",
        sex: "some sex",
        specialities: "some specialities"
      }

      assert {:ok, %Expert{} = expert} = PetHealthExpert.create_expert(valid_attrs)
      assert expert.age == 42
      assert expert.email == "some email"
      assert expert.name == "some name"
      assert expert.sex == "some sex"
      assert expert.specialities == "some specialities"
    end

    test "create_expert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.create_expert(@invalid_attrs)
    end

    test "update_expert/2 with valid data updates the expert" do
      expert = expert_fixture()

      update_attrs = %{
        age: 43,
        email: "some updated email",
        name: "some updated name",
        sex: "some updated sex",
        specialities: "some updated specialities"
      }

      assert {:ok, %Expert{} = expert} = PetHealthExpert.update_expert(expert, update_attrs)
      assert expert.age == 43
      assert expert.email == "some updated email"
      assert expert.name == "some updated name"
      assert expert.sex == "some updated sex"
      assert expert.specialities == "some updated specialities"
    end

    test "update_expert/2 with invalid data returns error changeset" do
      expert = expert_fixture()
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.update_expert(expert, @invalid_attrs)
      assert expert == PetHealthExpert.get_expert!(expert.id)
    end

    test "delete_expert/1 deletes the expert" do
      expert = expert_fixture()
      assert {:ok, %Expert{}} = PetHealthExpert.delete_expert(expert)
      assert_raise Ecto.NoResultsError, fn -> PetHealthExpert.get_expert!(expert.id) end
    end

    test "change_expert/1 returns a expert changeset" do
      expert = expert_fixture()
      assert %Ecto.Changeset{} = PetHealthExpert.change_expert(expert)
    end
  end
end

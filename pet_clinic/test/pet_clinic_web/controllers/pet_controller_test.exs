defmodule PetClinicWeb.PetControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetClinicServiceFixtures
  import PetClinic.PetHealthExpertFixtures
  import PetClinic.PetOwnerFixtures
  import PetClinic.PetTypeFixtures
  import PetClinic.Factory

  @create_attrs %{age: 42, name: "some name", sex: "female", type_id: 1, owner_id: 2, expert_id: 1}
  @update_attrs %{
    age: 43,
    name: "some updated name",
    sex: "female",
    type_id: 1,
    owner_id: 1,
    expert_id: 1
  }
  @invalid_attrs %{age: nil, name: nil, sex: nil, type_id: nil, owner_id: nil, expert_id: nil }



  describe "index" do
    test "lists all pets", %{conn: conn} do
      conn = get(conn, Routes.pet_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Pets"
    end
  end

  describe "new pet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pet_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pet"
    end
  end

  describe "create pet" do
    setup [:owners_fixture, :experts_fixture, :pet_types_fixture, :pets_fixture]
    test "redirects to show when data is valid", %{conn: conn} = context do

      create_attrs = params_for(:pet,
                                age: context.pet_0.age,
                                name: context.pet_0.name,
                                sex: context.pet_0.sex,
                                type_id: context.pet_type_0.id,
                                owner_id: context.owner_0.id,
                                expert_id: context.expert_0.id)

      conn = post(conn, Routes.pet_path(conn, :create), pet: create_attrs)
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pet_path(conn, :show, id)

      conn = get(conn, Routes.pet_path(conn, :show, id))
      assert html_response(conn, 200) =~ "My title"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pet_path(conn, :create), pet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pet"
    end
  end

  describe "edit pet" do
    setup [:owners_fixture, :experts_fixture, :pet_types_fixture, :pets_fixture]
    test "renders form for editing chosen pet", %{conn: conn, pet_0: pet} do
      conn = get(conn, Routes.pet_path(conn, :edit, pet))
      assert html_response(conn, 200) =~ "Edit Pet"
    end
  end

  describe "update pet" do
    setup [:owners_fixture, :experts_fixture, :pet_types_fixture, :pets_fixture]
    test "redirects when data is valid", %{conn: conn, pet_0: pet}= context do
      update_attrs = params_for(:pet,
                                age: context.pet_1.age,
                                name: context.pet_1.name,
                                sex: context.pet_1.sex,
                                type_id: context.pet_type_1.id,
                                owner_id: context.owner_1.id,
                                expert_id: context.expert_1.id)

      conn = put(conn, Routes.pet_path(conn, :update, pet), pet: update_attrs)
      assert redirected_to(conn) == Routes.pet_path(conn, :show, pet)

      conn = get(conn, Routes.pet_path(conn, :show, pet))
      assert html_response(conn, 200) =~ "My title"
    end

    @tag :renders_pet
    test "renders errors when data is invalid", %{conn: conn, pet_0: pet} do
      conn = put(conn, Routes.pet_path(conn, :update, pet), pet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pet"
    end
  end

  describe "delete pet" do
    #setup [:create_pet]
    setup [:owners_fixture, :experts_fixture, :pet_types_fixture, :pets_fixture]

    test "deletes chosen pet", %{conn: conn, pet_0: pet} do
      conn = delete(conn, Routes.pet_path(conn, :delete, pet))
      assert redirected_to(conn) == Routes.pet_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pet_path(conn, :show, pet))
      end
    end
  end

  defp create_pet(_) do
    pet = pets_fixture()
    %{pet: pet}
  end
end

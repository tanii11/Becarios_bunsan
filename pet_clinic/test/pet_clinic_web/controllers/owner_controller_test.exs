defmodule PetClinicWeb.OwnerControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetOwnerFixtures

  @create_attrs %{age: 42, email: "some email", name: "some name", phone_num: "some phone_num"}
  @update_attrs %{
    age: 43,
    email: "some updated email",
    name: "some updated name",
    phone_num: "some updated phone_num"
  }
  @invalid_attrs %{age: nil, email: nil, name: nil, phone_num: nil}

  describe "fixture" do
    @tag :owner
    setup [:owners_fixture]
    test "probando expert", context do
      IO.inspect(context)
    end
  end

  describe "index" do
    test "lists all owners", %{conn: conn} do
      conn = get(conn, Routes.owner_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Owners"
    end
  end

  describe "new owner" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.owner_path(conn, :new))
      assert html_response(conn, 200) =~ "New Owner"
    end
  end

  describe "create owner" do
    setup [:owners_fixture]
    test "redirects to show when data is valid", %{conn: conn} = context do
      create_attrs = params_for(:owner,
                                age: context.owner_0.age,
                                email: context.owner_0.email,
                                name: context.owner_0.name,
                                phone_num: context.owner_0.phone_num)

      conn = post(conn, Routes.owner_path(conn, :create), owner: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.owner_path(conn, :show, id)

      conn = get(conn, Routes.owner_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Owner"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.owner_path(conn, :create), owner: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Owner"
    end
  end

  describe "edit owner" do
    @tag :edit_owner
    setup [:owners_fixture]

    test "renders form for editing chosen owner", %{conn: conn, owner_0: owner} do
      conn = get(conn, Routes.owner_path(conn, :edit, owner))
      assert html_response(conn, 200) =~ "Edit Owner"
    end
  end

  describe "update owner" do
    setup [:owners_fixture]

    test "redirects when data is valid", %{conn: conn, owner_0: owner} = context do
      update_attrs = params_for(:owner,
                                age: context.owner_1.age,
                                email: context.owner_1.email,
                                name: context.owner_1.name,
                                phone_num: context.owner_1.phone_num)

      conn = put(conn, Routes.owner_path(conn, :update, owner), owner: update_attrs)
      assert redirected_to(conn) == Routes.owner_path(conn, :show, owner)

      conn = get(conn, Routes.owner_path(conn, :show, owner))
      assert html_response(conn, 200) =~ "My title"
    end

    test "renders errors when data is invalid", %{conn: conn, owner_0: owner} do
      conn = put(conn, Routes.owner_path(conn, :update, owner), owner: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Owner"
    end
  end

  describe "delete owner" do
    setup [:owners_fixture]

    test "deletes chosen owner", %{conn: conn, owner_0: owner} do
      conn = delete(conn, Routes.owner_path(conn, :delete, owner))
      assert redirected_to(conn) == Routes.owner_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.owner_path(conn, :show, owner))
      end
    end
  end

  defp create_owner(_) do
    owner = owners_fixture()
    %{owner: owner}
  end
end

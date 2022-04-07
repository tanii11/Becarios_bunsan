defmodule PetClinicWeb.ExpertControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetHealthExpertFixtures

  @create_attrs %{age: 42, email: "some email", name: "some name", sex: "some sex", specialities: "some specialities"}
  @update_attrs %{age: 43, email: "some updated email", name: "some updated name", sex: "some updated sex", specialities: "some updated specialities"}
  @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

  describe "index" do
    test "lists all experts", %{conn: conn} do
      conn = get(conn, Routes.expert_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Experts"
    end
  end

  describe "new expert" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.expert_path(conn, :new))
      assert html_response(conn, 200) =~ "New Expert"
    end
  end

  describe "create expert" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.expert_path(conn, :create), expert: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.expert_path(conn, :show, id)

      conn = get(conn, Routes.expert_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Expert"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.expert_path(conn, :create), expert: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Expert"
    end
  end

  describe "edit expert" do
    setup [:create_expert]

    test "renders form for editing chosen expert", %{conn: conn, expert: expert} do
      conn = get(conn, Routes.expert_path(conn, :edit, expert))
      assert html_response(conn, 200) =~ "Edit Expert"
    end
  end

  describe "update expert" do
    setup [:create_expert]

    test "redirects when data is valid", %{conn: conn, expert: expert} do
      conn = put(conn, Routes.expert_path(conn, :update, expert), expert: @update_attrs)
      assert redirected_to(conn) == Routes.expert_path(conn, :show, expert)

      conn = get(conn, Routes.expert_path(conn, :show, expert))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, expert: expert} do
      conn = put(conn, Routes.expert_path(conn, :update, expert), expert: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Expert"
    end
  end

  describe "delete expert" do
    setup [:create_expert]

    test "deletes chosen expert", %{conn: conn, expert: expert} do
      conn = delete(conn, Routes.expert_path(conn, :delete, expert))
      assert redirected_to(conn) == Routes.expert_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.expert_path(conn, :show, expert))
      end
    end
  end

  defp create_expert(_) do
    expert = expert_fixture()
    %{expert: expert}
  end
end

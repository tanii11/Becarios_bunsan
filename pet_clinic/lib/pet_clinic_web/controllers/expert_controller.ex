defmodule PetClinicWeb.ExpertController do
  use PetClinicWeb, :controller

  alias PetClinic.PetHealthExpert
  alias PetClinic.PetHealthExpert.Expert

  def index(conn, _params) do
    experts = PetHealthExpert.list_experts()
    render(conn, "index.html", experts: experts)
  end

  def new(conn, _params) do
    changeset = PetHealthExpert.change_expert(%Expert{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"expert" => expert_params}) do
    case PetHealthExpert.create_expert(expert_params) do
      {:ok, expert} ->
        conn
        |> put_flash(:info, "Expert created successfully.")
        |> redirect(to: Routes.expert_path(conn, :show, expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    expert = PetHealthExpert.get_expert!(id)
    render(conn, "show.html", expert: expert)
  end

  def edit(conn, %{"id" => id}) do
    expert = PetHealthExpert.get_expert!(id)
    changeset = PetHealthExpert.change_expert(expert)
    render(conn, "edit.html", expert: expert, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expert" => expert_params}) do
    expert = PetHealthExpert.get_expert!(id)

    case PetHealthExpert.update_expert(expert, expert_params) do
      {:ok, expert} ->
        conn
        |> put_flash(:info, "Expert updated successfully.")
        |> redirect(to: Routes.expert_path(conn, :show, expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expert: expert, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    expert = PetHealthExpert.get_expert!(id)
    {:ok, _expert} = PetHealthExpert.delete_expert(expert)

    conn
    |> put_flash(:info, "Expert deleted successfully.")
    |> redirect(to: Routes.expert_path(conn, :index))
  end
end

defmodule PetClinicWeb.ExpertController do
  use PetClinicWeb, :controller

  alias PetClinic.Repo
  alias PetClinic.PetHealthExpert
  alias PetClinic.PetHealthExpert.Expert
  alias PetClinic.PetClinicService

  def index(conn, _params) do
    experts = PetHealthExpert.list_experts()
    render(conn, "index.html", experts: experts)
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"expert" => expert_params}) do
    specialities = PetClinicService.list_pet_types()

    case PetHealthExpert.create_expert(expert_params) do
      {:ok, expert} ->
        conn
        |> put_flash(:info, "Expert created successfully.")
        |> redirect(to: Routes.expert_path(conn, :show, expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, specialities: specialities)
    end
  end

  def show(conn, %{"id" => id}) do
    expert = PetHealthExpert.get_expert!(id)
    render(conn, "show.html", expert: expert)
  end

  def edit(conn, %{"id" => id}) do
    expert = PetHealthExpert.get_expert!(id) |> Repo.preload(:specialities)
    specialities = Enum.map(expert.specialities, fn x -> x.id end)
    changeset = PetHealthExpert.change_expert(expert, %{specialities: specialities})
    specialities = PetHealthExpert.list_specialities(id)
    render(conn, "edit.html", expert: expert, specialities: specialities, changeset: changeset)
  end

  def new(conn, params) do
    specialities = PetClinicService.list_pet_types()
    changeset = PetHealthExpert.change_expert(%Expert{} |> Repo.preload(:specialities), %{})

    render(conn, "new.html", changeset: changeset, specialities: specialities)
  end

  def update(conn, %{"id" => id, "expert" => expert_params}) do
    specialities = PetClinicService.list_pet_types()
    expert = PetHealthExpert.get_expert!(id)

    case PetHealthExpert.update_expert(expert, expert_params) do
      {:ok, expert} ->
        conn
        |> put_flash(:info, "Expert updated successfully.")
        |> redirect(to: Routes.expert_path(conn, :show, expert))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", expert: expert, changeset: changeset, specialities: specialities)
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

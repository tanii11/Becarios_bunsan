defmodule PetClinicWeb.AppointmentController do
  use PetClinicWeb, :controller


  alias PetClinic.AppointmentService
  alias PetClinic.AppointmentService.ExpertSchedule
  alias PetClinic.PetHealthExpert
  alias PetClinic.PetClinicService


  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, %{"id" => id, "datetime" => date }) do
    appointments = AppointmentService.get_appointment(id, date)
    render(conn, "index.html", appointments: appointments)
  end




end

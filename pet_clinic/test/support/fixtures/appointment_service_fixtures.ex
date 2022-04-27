defmodule PetClinic.AppointmentServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.AppointmentService` context.
  """

  @doc """
  Generate a expert_schedule.
  """
  def expert_schedule_fixture(attrs \\ %{}) do
    {:ok, expert_schedule} =
      attrs
      |> Enum.into(%{

      })
      |> PetClinic.AppointmentService.create_expert_schedule()

    expert_schedule
  end
end

defmodule PetClinic.AppointmentServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.AppointmentService` context.
  """

  @doc """
  Generate a expert_schedule.
  """
  # def expert_schedule_fixture(attrs \\ %{}) do
  #   {:ok, expert_schedule} =
  #     attrs
  #     |> Enum.into(%{
  #       monday_start: "10:00:00",
  #       monday_end: "20:00:00",
  #       tuesday_start: "10:00:00",
  #       tuesday_end: "20:00:00",
  #       wednesday_start: "10:00:00",
  #       wednesday_end: "20:00:00",
  #       thursday_start: "10:00:00",
  #       thursday_end: "20:00:00",
  #       friday_start: "10:00:00",
  #       friday_end: "20:00:00",
  #       saturday_start: "10:00:00",
  #       saturday_end: "20:00:00",
  #       sunday_start: "10:00:00",
  #       sunday_end: "20:00:00",
  #       week_start: "2022-05-23",
  #       week_end: "2022-05-29",
  #       expert_id: expert_id
  #     })
  #     |> PetClinic.AppointmentService.create_expert_schedule()

  #   expert_schedule
  # end
  import PetClinic.Factory

  def expert_schedules_fixture(attrs \\ %{}) do
    expert = attrs.expert_0

    %{
      expert_schedule_0:
        insert(:expert_schedule,
          monday_start: "10:00:00",
          monday_end: "20:00:00",
          tuesday_start: "10:00:00",
          tuesday_end: "20:00:00",
          wednesday_start: "10:00:00",
          wednesday_end: "20:00:00",
          thursday_start: "10:00:00",
          thursday_end: "20:00:00",
          friday_start: "10:00:00",
          friday_end: "20:00:00",
          saturday_start: "10:00:00",
          saturday_end: "20:00:00",
          sunday_start: "10:00:00",
          sunday_end: "20:00:00",
          week_start: "2022-05-23",
          week_end: "2022-05-29",
          expert_id: expert.id
        )
    }
  end
end

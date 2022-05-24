defmodule PetClinic.AppointmentServiceTest do
  use PetClinic.DataCase

  alias PetClinic.AppointmentService
  alias PetClinic.AppointmentService.ExpertSchedule
  import PetClinic.AppointmentServiceFixtures
  import PetClinic.PetHealthExpertFixtures

  describe "fixture" do
    @tag :schedule
    setup [:experts_fixture, :expert_schedules_fixture]
    test "probando expert", context do
      IO.inspect(context)
    end
  end

  describe "expert_schedules" do
    setup [:experts_fixture, :expert_schedules_fixture]


    @invalid_attrs %{
      monday_start: nil,
    monday_end: nil,
    tuesday_start: nil,
    tuesday_end: nil,
    wednesday_start: nil,
    wednesday_end: nil,
    thursday_start: nil,
    thursday_end: nil,
    friday_start: nil,
    friday_end: nil,
    saturday_start: nil,
    saturday_end: nil,
    sunday_start: nil,
    sunday_end: nil,
    week_start: nil,
    week_end: nil,
    expert_id: nil
  }

    test "list_expert_schedules/0 returns all expert_schedules", %{expert_schedule_0: expert_schedule} do
      #expert_schedule = expert_schedules_fixture()
      assert AppointmentService.list_expert_schedules() == [expert_schedule]
    end

    test "get_expert_schedule!/1 returns the expert_schedule with given id", %{expert_schedule_0: expert_schedule} do
      #expert_schedule = expert_schedules_fixture()
      assert AppointmentService.get_expert_schedule!(expert_schedule.id) == expert_schedule
    end

    test "create_expert_schedule/1 with valid data creates a expert_schedule", context do
      valid_attrs = params_for(:expert_schedule, expert_id: context.expert_0.id)

      assert {:ok, %ExpertSchedule{} = expert_schedule} =
               AppointmentService.create_expert_schedule(valid_attrs)
    end

    test "create_expert_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AppointmentService.create_expert_schedule(@invalid_attrs)
    end

    test "update_expert_schedule/2 with valid data updates the expert_schedule", %{expert_schedule_0: expert_schedule} do
      #expert_schedule = expert_schedules_fixture()
      update_attrs = %{}

      assert {:ok, %ExpertSchedule{} = expert_schedule} =
               AppointmentService.update_expert_schedule(expert_schedule, update_attrs)
    end

    test "update_expert_schedule/2 with invalid data returns error changeset", %{expert_schedule_0: expert_schedule} do
      #expert_schedule = expert_schedules_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.update_expert_schedule(expert_schedule, @invalid_attrs)

      assert expert_schedule == AppointmentService.get_expert_schedule!(expert_schedule.id)
    end

    test "delete_expert_schedule/1 deletes the expert_schedule", %{expert_schedule_0: expert_schedule} do
      #expert_schedule = expert_schedules_fixture()
      assert {:ok, %ExpertSchedule{}} = AppointmentService.delete_expert_schedule(expert_schedule)

      assert_raise Ecto.NoResultsError, fn ->
        AppointmentService.get_expert_schedule!(expert_schedule.id)
      end
    end

    test "change_expert_schedule/1 returns a expert_schedule changeset", %{expert_schedule_0: expert_schedule} do
      #expert_schedule = expert_schedules_fixture()
      assert %Ecto.Changeset{} = AppointmentService.change_expert_schedule(expert_schedule)
    end
  end
end

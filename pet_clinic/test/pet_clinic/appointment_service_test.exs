defmodule PetClinic.AppointmentServiceTest do
  use PetClinic.DataCase

  alias PetClinic.AppointmentService

  describe "expert_schedules" do
    alias PetClinic.AppointmentService.ExpertSchedule

    import PetClinic.AppointmentServiceFixtures

    @invalid_attrs %{}

    test "list_expert_schedules/0 returns all expert_schedules" do
      expert_schedule = expert_schedule_fixture()
      assert AppointmentService.list_expert_schedules() == [expert_schedule]
    end

    test "get_expert_schedule!/1 returns the expert_schedule with given id" do
      expert_schedule = expert_schedule_fixture()
      assert AppointmentService.get_expert_schedule!(expert_schedule.id) == expert_schedule
    end

    test "create_expert_schedule/1 with valid data creates a expert_schedule" do
      valid_attrs = %{}

      assert {:ok, %ExpertSchedule{} = expert_schedule} = AppointmentService.create_expert_schedule(valid_attrs)
    end

    test "create_expert_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AppointmentService.create_expert_schedule(@invalid_attrs)
    end

    test "update_expert_schedule/2 with valid data updates the expert_schedule" do
      expert_schedule = expert_schedule_fixture()
      update_attrs = %{}

      assert {:ok, %ExpertSchedule{} = expert_schedule} = AppointmentService.update_expert_schedule(expert_schedule, update_attrs)
    end

    test "update_expert_schedule/2 with invalid data returns error changeset" do
      expert_schedule = expert_schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = AppointmentService.update_expert_schedule(expert_schedule, @invalid_attrs)
      assert expert_schedule == AppointmentService.get_expert_schedule!(expert_schedule.id)
    end

    test "delete_expert_schedule/1 deletes the expert_schedule" do
      expert_schedule = expert_schedule_fixture()
      assert {:ok, %ExpertSchedule{}} = AppointmentService.delete_expert_schedule(expert_schedule)
      assert_raise Ecto.NoResultsError, fn -> AppointmentService.get_expert_schedule!(expert_schedule.id) end
    end

    test "change_expert_schedule/1 returns a expert_schedule changeset" do
      expert_schedule = expert_schedule_fixture()
      assert %Ecto.Changeset{} = AppointmentService.change_expert_schedule(expert_schedule)
    end
  end
end

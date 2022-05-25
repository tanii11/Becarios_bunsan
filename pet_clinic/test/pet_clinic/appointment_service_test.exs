defmodule PetClinic.AppointmentServiceTest do
  use PetClinic.DataCase

  alias PetClinic.AppointmentService
  alias PetClinic.Appointment
  alias PetClinic.AppointmentService.ExpertSchedule
  import PetClinic.AppointmentServiceFixtures
  import PetClinic.PetHealthExpertFixtures
  import PetClinic.PetClinicServiceFixtures
  import PetClinic.PetOwnerFixtures
  import PetClinic.PetTypeFixtures
  import PetClinic.AppointmentFixtures

  describe "appointments" do
    setup [
      :owners_fixture,
      :experts_fixture,
      :expert_schedules_fixture,
      :pet_types_fixture,
      :pets_fixture,
      :appointments_fixture
    ]

    # test "probando expert", context do
    #   IO.inspect(context)
    # end

    test "correct Appointment", context do
      assert {:ok, %Appointment{}} =
               AppointmentService.new_appointment(
                 context.appointment_0.expert_id,
                 context.appointment_0.pet_id,
                 DateTime.utc_now() |> DateTime.add(3600, :second)
               )
    end

    test "invalid expert_id of Appointment", context do
      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.new_appointment(
                 0,
                 context.appointment_0.pet_id,
                 context.appointment_0.datetime
               )
    end

    test "invalid pet_id of Appointment", context do
      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.new_appointment(
                 context.appointment_0.expert_id,
                 0,
                 context.appointment_0.datetime
               )
    end

    test "validate datetime in the past in Appointment", context do
      assert {:error, "datetime is in the past"} ==
               AppointmentService.new_appointment(
                 context.appointment_1.expert_id,
                 context.appointment_1.pet_id,
                 context.appointment_1.datetime
               )
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

    # test "valid Expert Schedule", context do
    #   assert {:ok, %ExpertSchedule{}} ==
    #   AppointmentService.available_slots(context.expert_0.id, ~D[2022-04-26], ~D[2022-04-26])
    # end

    test "list_expert_schedules/0 returns all expert_schedules", %{
      expert_schedule_0: expert_schedule
    } do
      assert AppointmentService.list_expert_schedules() == [expert_schedule]
    end

    test "get_expert_schedule!/1 returns the expert_schedule with given id", %{
      expert_schedule_0: expert_schedule
    } do
      assert AppointmentService.get_expert_schedule!(expert_schedule.id) == expert_schedule
    end

    # test "create_expert_schedule/1 with valid data creates a expert_schedule", context do
    #   valid_attrs = params_for(:expert_schedule, expert_id: context.expert_0.id)

    #   assert {:ok, %ExpertSchedule{}} = AppointmentService.create_expert_schedule(valid_attrs)
    # end

    test "create_expert_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.create_expert_schedule(@invalid_attrs)
    end

    test "update_expert_schedule/2 with valid data updates the expert_schedule", %{
      expert_schedule_0: expert_schedule
    } do
      update_attrs = %{}

      assert {:ok, %ExpertSchedule{}} =
               AppointmentService.update_expert_schedule(expert_schedule, update_attrs)
    end

    test "update_expert_schedule/2 with invalid data returns error changeset", %{
      expert_schedule_0: expert_schedule
    } do
      assert {:error, %Ecto.Changeset{}} =
               AppointmentService.update_expert_schedule(expert_schedule, @invalid_attrs)

      assert expert_schedule == AppointmentService.get_expert_schedule!(expert_schedule.id)
    end

    test "delete_expert_schedule/1 deletes the expert_schedule", %{
      expert_schedule_0: expert_schedule
    } do
      assert {:ok, %ExpertSchedule{}} = AppointmentService.delete_expert_schedule(expert_schedule)

      assert_raise Ecto.NoResultsError, fn ->
        AppointmentService.get_expert_schedule!(expert_schedule.id)
      end
    end

    test "change_expert_schedule/1 returns a expert_schedule changeset", %{
      expert_schedule_0: expert_schedule
    } do
      assert %Ecto.Changeset{} = AppointmentService.change_expert_schedule(expert_schedule)
    end
  end
end

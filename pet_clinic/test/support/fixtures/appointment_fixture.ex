defmodule PetClinic.AppointmentFixtures do
  @moduledoc """
   this module define the fixture Appointment
  """
  import PetClinic.Factory

  def appointments_fixture(attrs \\ %{}) do
    pet = attrs.pet_0
    expert = attrs.expert_0

    %{
      appointment_0:
        insert(:appointment,
          datetime: ~U[2022-05-27 14:30:00Z],
          pet_id: pet.id,
          expert_id: expert.id
        ),
      appointment_1:
        insert(:appointment,
          datetime: ~U[2022-05-10 04:21:10Z],
          pet_id: pet.id,
          expert_id: expert.id
        )
    }
  end
end

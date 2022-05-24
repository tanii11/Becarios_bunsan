defmodule PetClinic.Factory do
  use ExMachina.Ecto, repo: PetClinic.Repo

  def pet_factory do
    %PetClinic.PetClinicService.Pet{
      age: 42,
      name: "some name",
      sex: "female"
    }
  end

  def expert_factory do
    %PetClinic.PetHealthExpert.Expert{
      age: 42,
      email: "some email",
      name: "some name",
      sex: "female"
    }
  end


  def owner_factory do
    %PetClinic.PetOwner.Owner{
      age: 42,
      email: "some email",
      name: "some name",
      phone_num: "some phone_num"
    }
  end

  def pet_type_factory do
    %PetClinic.PetType{
      name: "some name"
    }
  end

  def expert_schedule_factory do
    %PetClinic.AppointmentService.ExpertSchedule{
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
      week_end: "2022-05-29"
    }
  end
end

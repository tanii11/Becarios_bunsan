defmodule PetClinic.AppointmentService do
  @moduledoc """
  The AppointmentService context.
  """

  import Ecto.Query, warn: false
  alias PetClinic.Repo
  alias PetClinic.Appointment
  alias PetClinic.PetClinicService.Pet

  alias PetClinic.AppointmentService.ExpertSchedule

  @doc """
  Returns the list of expert_schedules.

  ## Examples

      iex> list_expert_schedules()
      [%ExpertSchedule{}, ...]

  """
  def list_expert_schedules do
    Repo.all(ExpertSchedule)
  end

  def new_appointment(expert_id, pet_id, datetime) do
    if Repo.one(from e in ExpertSchedule, where: e.expert_id == ^expert_id) == nil do
      {:error, "expert with id = #{expert_id} doesn´t exist"}
    else
      if Repo.one(from p in Pet, where: p.id == ^pet_id) == nil do
        {:error, "pet with id = #{pet_id} doesn´t exist"  }
      else
        time = NaiveDateTime.to_time(datetime)
        date = NaiveDateTime.to_date(datetime)
        options = available_slots(expert_id, date, date)

        if Map.get(options, date) |> Enum.filter(fn opt-> Time.compare(opt, time) == :eq end) == [] do
          {:error, "This schedule is already busy"}
        else
           appointment = %Appointment{expert_id: expert_id, pet_id: pet_id, datetime: DateTime.from_naive!(datetime, "Etc/UTC")}
           Repo.insert(appointment)
        end
      end
    end
  end

  def available_slots(expert_id, from_date, to_date) do
    schedule = Repo.one(from e in ExpertSchedule, where: e.expert_id == ^expert_id)
    if schedule == nil do
      {:error, "expert with id = #{expert_id} doesn´t exist"}
    else
      #obtener el inicio y fin de rango
      init_date = max_date(from_date, schedule.week_start)
      finish_date = min_date(to_date, schedule.week_end)
      days_range = Date.range(init_date, finish_date)
      Map.new(days_range, fn d->
        {d, repeat(d, schedule, expert_id)}
      end)
    end
  end


  def repeat(init_date, schedule, expert_id) do
    {initial_time, ending_time} = get_day(init_date, schedule)
    slots = time_range(initial_time, ending_time)

    appointment = Repo.all(from a in Appointment, where: a.expert_id == ^expert_id, select: a.datetime)
    |> Enum.filter(fn a ->
      Date.compare(init_date, DateTime.to_date(a)) == :eq
    end)

    busy = Enum.map(appointment, fn a ->
      DateTime.to_time(a)
    end)

    Enum.filter(slots, fn slot ->
      Enum.all?(busy, fn time ->
        Time.compare(slot, time) != :eq
     end)
    end)
  end

  def time_range(init_time, end_time) do
    case Time.compare(init_time, end_time) do
      :gt -> []
      :eq -> [init_time]
      :lt ->
        rec = Time.add(init_time, 1800)
        [init_time | time_range(rec, end_time)]
    end
  end

  def get_day(init_date, schedule) do
    case Date.day_of_week(init_date) do
      1 -> {schedule.monday_start, schedule.monday_end}
      2 -> {schedule.tuesday_start, schedule.tuesday_end}
      3 -> {schedule.wednesday_start, schedule.wednesday_end}
      4 -> {schedule.thursday_start, schedule.thursday_end}
      5 -> {schedule.friday_start, schedule.friday_end}
      6 -> {schedule.saturday_start, schedule.saturday_end}
      7 -> {schedule.sunday_start, schedule.day_end}
    end
  end

  def min_date(d1, d2) do
    case Date.compare(d1, d2) do
      :gt -> d2
      :lt -> d1
      :eq -> d1
    end
  end
  def max_date(d1, d2) do
    case Date.compare(d1, d2) do
      :gt -> d1
      :lt -> d2
      :eq -> d1
    end
  end


  @doc """
  Gets a single expert_schedule.

  Raises `Ecto.NoResultsError` if the Expert schedule does not exist.

  ## Examples

      iex> get_expert_schedule!(123)
      %ExpertSchedule{}

      iex> get_expert_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expert_schedule!(id), do: Repo.get!(ExpertSchedule, id)

  @doc """
  Creates a expert_schedule.

  ## Examples

      iex> create_expert_schedule(%{field: value})
      {:ok, %ExpertSchedule{}}

      iex> create_expert_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expert_schedule(attrs \\ %{}) do
    %ExpertSchedule{}
    |> ExpertSchedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expert_schedule.

  ## Examples

      iex> update_expert_schedule(expert_schedule, %{field: new_value})
      {:ok, %ExpertSchedule{}}

      iex> update_expert_schedule(expert_schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expert_schedule(%ExpertSchedule{} = expert_schedule, attrs) do
    expert_schedule
    |> ExpertSchedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expert_schedule.

  ## Examples

      iex> delete_expert_schedule(expert_schedule)
      {:ok, %ExpertSchedule{}}

      iex> delete_expert_schedule(expert_schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expert_schedule(%ExpertSchedule{} = expert_schedule) do
    Repo.delete(expert_schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expert_schedule changes.

  ## Examples

      iex> change_expert_schedule(expert_schedule)
      %Ecto.Changeset{data: %ExpertSchedule{}}

  """
  def change_expert_schedule(%ExpertSchedule{} = expert_schedule, attrs \\ %{}) do
    ExpertSchedule.changeset(expert_schedule, attrs)
  end
end

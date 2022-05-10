defmodule InvoiceValidatorTest do
  use ExUnit.Case, async: false
  import InvoiceValidator

  Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)

  @tz_cdmx "Mexico/General"

  @pac_dt DateTime.from_naive!(~N[2022-03-23 15:06:35], @tz_cdmx)

  data = [
    {"72 hrs before", "America/Tijuana", ~N[2022-03-20 13:06:31],
     "ERROR: Invoice was issued more than 72 hrs before received by the PAC"},
    {"72 hrs before", "America/Mazatlan", ~N[2022-03-20 14:06:31],
     "ERROR: Invoice was issued more than 72 hrs before received by the PAC"},
    {"72 hrs before", "Mexico/General", ~N[2022-03-20 15:06:31],
     "ERROR: Invoice was issued more than 72 hrs before received by the PAC"},
    {"72 hrs before", "America/Cancun", ~N[2022-03-20 16:06:31],
     "ERROR: Invoice was issued more than 72 hrs before received by the PAC"},
    {"72 hrs before", "America/Tijuana", ~N[2022-03-20 13:06:35], :ok},
    {"72 hrs before", "America/Mazatlan", ~N[2022-03-20 14:06:35], :ok},
    {"72 hrs before", "Mexico/General", ~N[2022-03-20 15:06:35], :ok},
    {"72 hrs before", "America/Cancun", ~N[2022-03-20 16:06:35], :ok},
    {"05 min after", "America/Tijuana", ~N[2022-03-23 13:11:35], :ok},
    {"05 min after", "America/Mazatlan", ~N[2022-03-23 14:11:35], :ok},
    {"05 min after", "Mexico/General", ~N[2022-03-23 15:11:35], :ok},
    {"05 min after", "America/Cancun", ~N[2022-03-23 16:11:35], :ok},
    {"05 min after", "America/Tijuana", ~N[2022-03-23 13:11:36],
     "ERROR: Invoice is more than 5 mins ahead in time"},
    {"05 min after", "America/Mazatlan", ~N[2022-03-23 14:11:36],
     "ERROR: Invoice is more than 5 mins ahead in time"},
    {"05 min after", "Mexico/General", ~N[2022-03-23 15:11:36],
     "ERROR: Invoice is more than 5 mins ahead in time"},
    {"05 min after", "America/Cancun", ~N[2022-03-23 16:11:36],
     "ERROR: Invoice is more than 5 mins ahead in time"}
  ]

  for {time, time_zone, date, message} <- data do
    @time time
    @time_zone time_zone
    @date date
    @message message
    test "#{@time}, emisor in #{@time_zone} at #{@date} returns #{@message}" do
      # Change test implementation
      assert InvoiceValidator.validate_dates(datetime(@date, @time_zone), @pac_dt) == @message
    end
  end

  defp datetime(%NaiveDateTime{} = ndt, tz) do
    DateTime.from_naive!(ndt, tz)
  end
end

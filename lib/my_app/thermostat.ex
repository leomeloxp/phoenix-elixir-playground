defmodule MyApp.Thermostat do
  defstruct temperature: 293.15, room: "", unit: "°C"

  @kelvin_base 273.15

  def new(room) do
    %MyApp.Thermostat{
      room: room,
    }
  end

  def get_temperature(%MyApp.Thermostat{} = thermostat) do
    cond do
      thermostat.unit == "K" -> thermostat.temperature |> Float.round(1)
      thermostat.unit == "°F" -> ((thermostat.temperature - @kelvin_base) * 9 / 5) + 32 |> Float.round(1)
      true -> thermostat.temperature - @kelvin_base |> Float.round(1)
    end
  end

  def set_temperature(%MyApp.Thermostat{} = thermostat, new_temperature) do
    %{thermostat | temperature: new_temperature}
  end

  def toggle_unit(%MyApp.Thermostat{} = thermostat) do
    new_unit = cond do
      thermostat.unit == "°C" -> "°F"
      thermostat.unit == "°F" -> "K"
      true -> "°C"
    end
    %{thermostat | unit: new_unit}
  end
end

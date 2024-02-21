defmodule MyApp.Thermostat do
  defstruct temperature: 293.15, room: "", unit: "°C"

  @kelvin_base 273.15

  def new(room) do
    %MyApp.Thermostat{
      room: room,
    }
  end

  def get_temperature(%MyApp.Thermostat{unit: "K", temperature: temperature }) do
    temperature |> Float.round(1)
  end
  def get_temperature(%MyApp.Thermostat{unit: "°F", temperature: temperature }) do
    ((temperature - @kelvin_base) * 9 / 5) + 32 |> Float.round(1)
  end
  def get_temperature(%MyApp.Thermostat{unit: "°C", temperature: temperature }) do
    temperature - @kelvin_base |> Float.round(1)
  end

  def set_temperature(%MyApp.Thermostat{} = thermostat, new_temperature) do
    %{thermostat | temperature: new_temperature}
  end

  def toggle_unit(%MyApp.Thermostat{unit: "°C"} = thermostat) do
    %{thermostat | unit: "°F"}
  end
  def toggle_unit(%MyApp.Thermostat{unit: "°F"} = thermostat) do
    %{thermostat | unit: "K"}
  end
  def toggle_unit(%MyApp.Thermostat{} = thermostat) do
    %{thermostat | unit: "°C"}
  end
end

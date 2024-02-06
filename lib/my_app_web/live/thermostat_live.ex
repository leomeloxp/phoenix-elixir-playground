defmodule MyAppWeb.ThermostatLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use Phoenix.LiveView
  alias MyApp.Thermostat

  def render(assigns) do
    ~H"""
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }
      .wrapper {
        text-align: center;
        border: 3px solid rebeccapurple;
        border-radius: 10px;
        padding: 10px;
      }
      .controls { margin-top: 10px;
        display: flex;
        justify-content: space-between;
        gap: 10px;
      }
      strong {
        color: rebeccapurple;
      }
      button {
        padding: 10px 20px;
        background-color: rebeccapurple;
        color: white;
        border-radius: 10px;
        font-weight: bold;
      }
    </style>
    <div class="wrapper">
    Current temperature in <%= @thermostat.room %>: <strong><%= @thermostat |> Thermostat.get_temperature %> <%= @thermostat.unit %></strong>
    <div class="controls">
    <button phx-click="dec_temperature">-</button>
    <button phx-click="toggle_unit">°C / °F / K</button>
    <button phx-click="inc_temperature">+</button>
    </div>
    </div>
    """
  end

  def mount(%{"room" => room}, _session, socket) do
    thermostat = Thermostat.new(room)

    {:ok, assign(socket, :thermostat, thermostat)}
  end

  def handle_event("inc_temperature", _value, socket) do
    new_thermostat = Thermostat.set_temperature(socket.assigns.thermostat, socket.assigns.thermostat.temperature + 1)
    {:noreply, assign(socket, :thermostat, new_thermostat)}
  end

  def handle_event("dec_temperature", _value, socket) do
    new_thermostat = Thermostat.set_temperature(socket.assigns.thermostat, socket.assigns.thermostat.temperature - 1)
    {:noreply, assign(socket, :thermostat, new_thermostat)}
  end

  def handle_event("toggle_unit", _value, socket) do
    new_thermostat = socket.assigns.thermostat |> Thermostat.toggle_unit()
    {:noreply, assign(socket, :thermostat, new_thermostat)}
  end

end

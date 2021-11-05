defmodule Server.Inward do
  use GenServer
  alias Server.Logic

  def init(state) do
    {:ok, state}
  end

  def handle_call(request, _from, state) do
    case request do
      {:add, num} -> {:reply, Logic.add(state, num), Logic.add(state, num)}
      {:div, num} when num == 0 -> {:reply, Logic.divide(state, num), state}
      {:div, num} -> {:reply, Logic.divide(state, num), Logic.divide(state, num)}
      {:mult, num} -> {:reply, Logic.mult(state, num), Logic.mult(state, num)}
      :clean -> {:reply, Logic.clean(), Logic.clean()}
    end
  end

  def terminate(_reason, state) do
    IO.puts("Last state - #{state}")
  end
end

defmodule Server.Api do
  use GenServer
  alias Server.Logic

  def init(state) do
    {:ok, state}
  end

  def handle_call(request, _from, state) do
    case request do
      {:add, num} -> {:reply, Logic.add(state, num), Logic.add(state, num)}
      {:div, num} -> {:reply, Logic.div(state, num), Logic.div(state, num)}
      {:mult, num} -> {:reply, Logic.mult(state, num), Logic.mult(state, num)}
      :clean -> {:reply, Logic.clean(), Logic.clean()}
    end
  end
end

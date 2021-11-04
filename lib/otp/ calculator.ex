defmodule Calculator do
  use GenServer

  def add(num) do
    GenServer.call(__MODULE__, {:add, num})
  end

  def div(num) do
    GenServer.call(__MODULE__, {:div, num})
  end

  def mult(num) do
    GenServer.call(__MODULE__, {:mult, num})
  end

  def clean do
    GenServer.call(__MODULE__, :clean)
  end

  def start_link(start_state) do
    GenServer.start_link(__MODULE__, start_state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call(request, _from, state) do
    case request do
      {:add, num} -> {:reply, state + num, state + num}
      {:div, num} when num == 0 -> {:reply, {:error, :division_by_zero}, state}
      {:div, num} -> {:reply, div(state, num), div(state, num)}
      {:mult, num} -> {:reply, state * num, state * num}
      :clean -> {:reply, 0, 0}
    end
  end
end

defmodule Server.Inward do
  @moduledoc """
  Server functions
  """
  use GenServer
  alias Server.Logic

  def init(state) do
    {:ok, state}
  end

  def handle_call({:add, num}, _from, state) do
    case Logic.add(state, num) do
      {:ok, result} -> {:reply, {:ok, result}, result}
      {:error, result} -> {:reply, {:error, result}, state}
    end
  end

  def handle_call({:mult, num}, _from, state) do
    case Logic.mult(state, num) do
      {:ok, result} -> {:reply, {:ok, result}, result}
      {:error, result} -> {:reply, {:error, result}, state}
    end
  end

  def handle_call({:div, num}, _from, state) do
    case Logic.divide(state, num) do
      {:ok, result} -> {:reply, {:ok, result}, result}
      {:error, :division_by_zero} -> {:reply, {:error, "division by zero"}, state}
      {:error, result} -> {:reply, {:error, result}, state}
    end
  end

  def handle_call(:clean, _from, _state) do
    result = Logic.clean()
    {:reply, {:ok, result}, result}
  end

  def terminate(_reason, state) do
    IO.puts("Last state - #{state}")
  end
end

defmodule Otp.Time do
  @moduledoc """
  Otp module
  GenServer.start_link(Otp.Time, [])
  """
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    Process.send_after(self(), :work, 1000)
    {:ok, Time.utc_now()}
  end

  def handle_info(:work, new_state) do
    IO.puts(Time.utc_now())
    Process.send_after(self(), :work, 1000)

    {:noreply, new_state}
  end
end

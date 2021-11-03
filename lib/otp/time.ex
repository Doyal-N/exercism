# GenServer.start_link(Otp.Time, [])
defmodule Otp.Time do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: EverySecond)
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

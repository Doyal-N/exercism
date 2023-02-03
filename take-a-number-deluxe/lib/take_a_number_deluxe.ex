defmodule TakeANumberDeluxe do
  alias TakeANumberDeluxe.State
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg), do: GenServer.start_link(__MODULE__, init_arg)

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :current_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :new_number)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset)

  # Server callbacks

  @impl GenServer
  def init(args) do
    timeout = Keyword.get(args, :auto_shutdown_timeout, :infinity)

    case State.new(args[:min_number], args[:max_number], timeout) do
      {:ok, state} -> {:ok, state, timeout}
      {:error, reason} -> {:stop, reason}
    end
  end

  @impl GenServer
  def handle_call(:current_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, number, new_state} -> {:reply, {:ok, number}, new_state, state.auto_shutdown_timeout}
      {:error, error} -> {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:queued_number, number}, _from, state) do
    case State.serve_next_queued_number(state, number) do
      {:ok, number, new_state} -> {:reply, {:ok, number}, new_state, state.auto_shutdown_timeout}
      {:error, error} -> {:reply, {:error, error}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, %State{min_number: min, max_number: max, auto_shutdown_timeout: limit}) do
    {:ok, state} = State.new(min, max, limit)
    {:noreply, state, limit}
  end

  @impl GenServer
  def handle_info(:timeout, _), do: exit(:normal)

  @impl GenServer
  def handle_info(_, state), do: {:noreply, state, state.auto_shutdown_timeout}
end

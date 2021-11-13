defmodule Server.App do
  @moduledoc """
  Supervisor module
  """
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  def init(_args) do
    children = [
      {Calculator, 0}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end

defmodule Calculator do
  @server Server.Api

  def start_link(start_state) do
    GenServer.start_link(@server, start_state, name: @server)
  end

  def add(num) do
    GenServer.call(@server, {:add, num})
  end

  def div(num) do
    GenServer.call(@server, {:div, num})
  end

  def mult(num) do
    GenServer.call(@server, {:mult, num})
  end

  def clean do
    GenServer.call(@server, :clean)
  end
end

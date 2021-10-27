defmodule LinkProcess do
  def run do
    pid = spawn(LinkProcess, :function, [self()])
    Process.monitor(pid)
  end

  def function(pid) do
    Process.sleep(6000)
    send(pid, "Huba")
  end

  def listen do
    receive do
      {:DOWN, _ref, :process, _pid, _reason} ->
        run()

      msg ->
        IO.puts("Message: #{inspect(msg)}")
    end

    listen()
  end
end

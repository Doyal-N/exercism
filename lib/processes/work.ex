defmodule Work do
  def create do
    spawn(Work, :receive_msg, ["foo"])
  end

  def receive_msg(msg) do
    receive do
      _msg when msg == "exit" ->
        IO.puts("Bye")
        exit(:normal)

      msg ->
        IO.puts(msg)
        receive_msg(msg)
    end
  end
end

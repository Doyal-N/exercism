# pid = Work.create
defmodule Work do
  def create do
    spawn(Work, :receive_msg, [])
  end

  def receive_msg do
    receive do
      :exit ->
        IO.puts("Bye, process died.")
        Process.exit(self(), :kill)

      msg ->
        IO.puts(msg)
        receive_msg()
    end
  end
end

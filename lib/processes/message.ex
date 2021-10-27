# pid = spawn(Processes.Message, :count_messages, [0])
defmodule Processes.Message do
  def count_messages(count) do
    receive do
      msg ->
        {:ok, msg}
        count_messages(count + 1)
    after
      60_000 -> IO.puts("Received #{count} messages")
    end
  end

  def async_time do
    1..4
    |> Task.async_stream(
      fn x ->
        :timer.sleep(2000)
        "#{x} - #{Time.utc_now()}"
      end,
      max_concurrency: 1,
      timeout: 10_000
    )
    |> Enum.each(&IO.inspect/1)

    Time.utc_now()
  end
end

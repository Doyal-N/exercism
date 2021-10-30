# pid = spawn(Message, :count_messages, [0])
defmodule Message do
  def count_messages(count) do
    receive do
      :count ->
        IO.puts("Received #{count} msg")
        exit(:normal)

      msg ->
        {:ok, msg}
        :timer.send_after(60_000, :count)
        count_messages(count + 1)
    end
  end

  def async_time do
    1..4
    |> Task.async_stream(
      fn x ->
        :timer.sleep(2000)
        "#{x} - #{Time.utc_now()}"
      end,
      max_concurrency: 4,
      timeout: 4_000
    )
    |> Enum.each(&IO.inspect/1)

    Time.utc_now()
  end
end

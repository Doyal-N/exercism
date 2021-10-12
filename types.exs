# 2 пункт
name = "Andry"

IO.puts "Hello " <> name
IO.puts "Hello #{name}"
IO.puts ~s(Hello #{name})
IO.puts ["Hello "] ++ name
IO.puts 'Hello ' ++ 'Andry'

# 3 пункт
data = %{day: 13, month: 10, year: 2001}

day = data.day
day = data[:day]
%{day: day, month: _, year: _} = data
{:ok, day} = Map.fetch(data, :day)
day = Map.fetch!(data, :day)
day = Map.get(data, :day)
[day, _, _] = Map.values(data)
{:day, day} = List.first(Map.to_list(data))
{:day, day} = Enum.at(data, 0)

# 4 пункт
list = ["foo", "bar", "baz"]

[_, _, third] = list
third = List.last(list)
{third, _} = List.pop_at(list, 2)
third = elem(List.to_tuple(list), 2)
third = Enum.at(list, 2)
third = List.last(tl(list))
third = Enum.fetch!(list, 2)

# 5 пункт
list1 = ["foo", "bar", "foobar"]
list2 = ["baz", "bar", "foo"]
uniq_elems = (list1 ++ list2) -- Enum.uniq(list1 ++ list2)

# 6 пункт

defmodule MySigils do
  def sigil_l(arg, []), do: String.length(arg)
  def sigil_l(arg, [?b]), do: byte_size(arg)
end

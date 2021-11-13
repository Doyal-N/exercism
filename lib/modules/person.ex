defmodule Person do
  @moduledoc """
  Struct Person
  """
  defstruct [:name, :surname, :age, :male]

  def update_person(person, key, value) do
    Map.put(person, key, value)
  end
end

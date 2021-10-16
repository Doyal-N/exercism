defmodule User do
  @moduledoc """
  User module
  """

  import Greeting
  import Majority

  defstruct [:name, :age]

  def greeting(%__MODULE__{name: name, age: age}) do
    if user_adult?(age) do
      hello(name)
    else
      "Access denied"
    end
  end
end

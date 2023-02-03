defmodule Mix.Tasks.Finish do
  @moduledoc "Commit and push code `mix finish`"
  use Mix.Task

  @shortdoc "Push to git"
  def run(msg) do
    System.cmd("git", ["add", "."])
    System.cmd("git", ["commit", "-m", "#{msg}"])
    System.cmd("git", ["push", "origin", "HEAD"])
  end
end

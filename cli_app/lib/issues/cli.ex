defmodule Issues.CLI do
  import Issues.TableFormatter, only: [print_columns: 2]

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(args) do
    args
    |> parse_args()
    |> process()
  end

  @spec parse_args([binary]) :: :help | {binary, binary, binary | 4}
  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> clear_args()
  end

  defp clear_args([user, project, count]), do: {user, project, String.to_integer(count)}
  defp clear_args([user, project]), do: {user, project, @default_count}
  defp clear_args(_), do: :help

  defp process(:help) do
    IO.puts("""
    usage: issues <user> <project> [ count | #{@default_count} ]
    """)

    System.halt(0)
  end

  defp process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_descending_order()
    |> take_last(count)
    |> print_columns(["number", "created_at", "title"])
  end

  defp decode_response({:ok, body}), do: body
  defp decode_response({:error, error}) do
    IO.puts("Error fetching from Github: #{error["message"]}")
    System.halt(2)
  end

  defp sort_into_descending_order(issues) do
    Enum.sort(issues, &(&1["created_at"] >= &2["created_at"]))
  end

  defp take_last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end
end

defmodule Issues.GithubIssues do
  @github_url Application.get_env(:issues, :github_url)
  @user_agent [Application.get_env(:issues, :user_agent)]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  defp issues_url(user, project), do: "#{@github_url}/repos/#{user}/#{project}/issues"

  defp handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_status(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_status(200), do: :ok
  defp check_status(_), do: :error
end

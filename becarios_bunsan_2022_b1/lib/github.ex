defmodule GitHub do
  use Tesla.Builder

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"User-Agent" , "Tesla"}]
  plug Tesla.Middleware.JSON

  def name_repos(owner) do
    client = new(1234)
    {:ok, repos} = user_repos(client, owner)
    Enum.map(repos.body, fn x -> x["name"] end)
  end

  def repo_info(owner, repo) do
    client = new(1234)
    {:ok, languages} = languages(client, owner, repo)
    {:ok, commits} = commits(client, owner, repo)
    commits_num = Enum.count(commits.body, fn x -> x end)
    {:ok, name} = repo(client, owner, repo)
    name_repo = name.body["name"]

    #%{:name => name_repo, :commits_num => commits_num, :languages => languages.body}
  end

  defp new(token) do
    Tesla.build_client([
      {Tesla.Middleware.Headers, [{"Authorization" , token}]}
    ])
  end

  defp user_repos(client, login) do
    get(client, "/users/" <> login <> "/repos")
  end

  defp repo(client, owner, repo) do
    get(client, "/repos/" <> owner <> "/" <> repo)
  end

  defp languages(client, owner, repo) do
    get(client, "/repos/" <> owner <> "/" <> repo <> "/languages")
  end

  defp commits(client, owner, repo) do
    get(client, "/repos/" <> owner <> "/" <> repo <> "/commits")
  end


end

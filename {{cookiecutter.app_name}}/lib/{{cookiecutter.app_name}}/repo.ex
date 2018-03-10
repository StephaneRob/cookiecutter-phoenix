defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}.Repo do
  use Ecto.Repo, otp_app: :{{cookiecutter.app_name}}
  use Scrivener, page_size: 30

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end

defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}.ReleaseTasks do
  @start_apps [
    :crypto,
    :ssl,
    :{% if cookiecutter.database == "postgresql" %}postgrex{% elif cookiecutter.database == "mysql" %}mariaex{% endif %},
    :ecto
  ]

  def repos, do: Application.get_env(:{{cookiecutter.app_name}}, :ecto_repos, [])

  defp prepare do
    me = :{{cookiecutter.app_name}}

    IO.puts("Loading #{me}..")
    # Load the code for {{cookiecutter.app_name}}, but don't start it
    :ok = Application.load(me)

    IO.puts("Starting dependencies..")
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s) for {{cookiecutter.app_name}}
    IO.puts("Starting repos..")
    Enum.each(repos(), & &1.start_link(pool_size: 1))
  end

  def migrate do
    prepare()
    Enum.each(repos(), &run_migrations_for/1)
  end

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp run_migrations_for(repo) do
    app = Keyword.get(repo.config, :otp_app)
    IO.puts("Running migrations for #{app}")
    Ecto.Migrator.run(repo, migrations_path(repo), :up, all: true)
  end

  def migrations_path(repo), do: priv_path_for(repo, "migrations")

  def priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)
    repo_underscore = repo |> Module.split() |> List.last() |> Macro.underscore()
    Path.join([priv_dir(app), repo_underscore, filename])
  end
end

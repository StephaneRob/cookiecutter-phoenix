defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor({{cookiecutter.app_name.split('_')|map('title')|join}}.Repo, []),
      # Start the endpoint when the application starts
      supervisor({{cookiecutter.app_name.split('_')|map('title')|join}}Web.Endpoint, [])
      # Start your own worker by calling: {{cookiecutter.app_name.split('_')|map('title')|join}}.Worker.start_link(arg1, arg2, arg3)
      # worker({{cookiecutter.app_name.split('_')|map('title')|join}}.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: {{cookiecutter.app_name.split('_')|map('title')|join}}.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Endpoint.config_change(changed, removed)
    :ok
  end
end

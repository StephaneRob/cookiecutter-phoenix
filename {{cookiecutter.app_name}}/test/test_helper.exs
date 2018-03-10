ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode({{cookiecutter.app_name.split('_')|map('title')|join}}.Repo, :manual)


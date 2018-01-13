use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :{{cookiecutter.app_name}}, {{cookiecutter.app_name_camel_case}}Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :{{cookiecutter.app_name}}, {{cookiecutter.app_name_camel_case}}.Repo,
  adapter: Ecto.Adapters.Postgres,
  {% if cookiecutter.test_database_username != "" %}
  username: "{{cookiecutter.test_database_username}}",
  {% endif %}
  {% if cookiecutter.test_database_password != "" %}
  password: "{{cookiecutter.test_database_password}}",
  {% endif %}
  database: "{{cookiecutter.app_name}}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

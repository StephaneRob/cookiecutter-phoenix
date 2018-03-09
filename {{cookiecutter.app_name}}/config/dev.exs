use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :{{cookiecutter.app_name}}, {{cookiecutter.app_name_camel_case}}Web.Endpoint,
  http: [port: {{cookiecutter.dev_port}}],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      "--color",
      "--config",
      "webpack.dev.js",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# command from your terminal:
#
#     openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem
#
# The `http:` config above can be replaced with:
#
#     https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :{{cookiecutter.app_name}}, {{cookiecutter.app_name_camel_case}}Web.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/{{cookiecutter.app_name}}_web/views/.*(ex)$},
      ~r{lib/{{cookiecutter.app_name}}_web/templates/.*(eex|slim|slime)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :{{cookiecutter.app_name}}, {{cookiecutter.app_name_camel_case}}.Repo,
  adapter: {% if cookiecutter.database == "postgreql" %}Ecto.Adapters.Postgres{% elif cookiecutter.database == "mysql" %}Ecto.Adapters.MySQL{% endif %},{% if cookiecutter.dev_database_username != "" %}
  username: "{{cookiecutter.dev_database_username}}",{% endif %}{% if cookiecutter.dev_database_password != "" %}
  password: "{{cookiecutter.dev_database_password}}",{% endif %}
  database: "{{cookiecutter.dev_database_name}}",
  hostname: "localhost",
  pool_size: 10

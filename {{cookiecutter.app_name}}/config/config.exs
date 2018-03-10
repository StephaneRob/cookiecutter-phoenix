# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :{{cookiecutter.app_name}},
  ecto_repos: [{{cookiecutter.app_name.split('_')|map('title')|join}}.Repo],
  locked_after: 4

# Configures the endpoint
config :{{cookiecutter.app_name}}, {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "svqSRdYYcf3Nm8BI3XwQJJvNsydLw4M4trm8T+vqvUzXGtWVy9+usJENd7FMiJ9t",
  render_errors: [view: {{cookiecutter.app_name.split('_')|map('title')|join}}Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: {{cookiecutter.app_name.split('_')|map('title')|join}}.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :{{cookiecutter.app_name}}, {{cookiecutter.app_name.split('_')|map('title')|join}}.Guardian,
  issuer: "{{cookiecutter.app_name}}",
  ttl: {2, :days},
  verify_issuer: true,
  secret_key: "Cmw+/MruMSIOr5B8d7Nlyj+IeS9OdUYWr/J+Eg/NK0RBMKvjhM+UbKgyE1h9lTki"

config :scrivener_html,
  routes_helper: {{cookiecutter.app_name.split('_')|map('title')|join}}.Router.Helpers,
  view_style: :bootstrap_v4

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

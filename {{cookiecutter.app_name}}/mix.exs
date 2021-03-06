defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}.Mixfile do
  use Mix.Project

  def project do
    [
      app: :{{cookiecutter.app_name}},
      version: "{{cookiecutter.version}}",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {% raw %}{{% endraw %}{{cookiecutter.app_name.split('_')|map('title')|join}}.Application, []{% raw %}}{% endraw %},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.2"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.3"},
      {:ecto, "~> 2.2.10"},
      {:timex, "~> 3.2.1"},
      {:timex_ecto, "~> 3.2.1"},
      {% raw %}{{% endraw %}{% if cookiecutter.database == "postgresql" %}:postgrex, "~> 0.13.3"{% elif cookiecutter.database == "mysql" %}:mariaex, ">= 0.0.0"{% endif %}{% raw %}}{% endraw %},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:guardian, "~> 1.0.1"},
      {:bcrypt_elixir, "~> 1.0.5"},
      {:comeonin, "~> 4.0.3"},
      {:scrivener_ecto, "~> 1.3.0"},
      {:scrivener_html, "~> 1.7.1"},
      {:distillery, "~> 1.5"},
      {:bootleg, "~> 0.6"},
      {:bootleg_phoenix, "~> 0.2"},
      {:bamboo, "~> 0.8"},
      {:bamboo_smtp, "~> 1.4.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

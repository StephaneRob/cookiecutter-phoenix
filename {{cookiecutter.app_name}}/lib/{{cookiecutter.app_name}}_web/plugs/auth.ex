defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Plug.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params) do
    assign(conn, :current_user, {{cookiecutter.app_name.split('_')|map('title')|join}}.Guardian.Plug.current_resource(conn))
  end
end

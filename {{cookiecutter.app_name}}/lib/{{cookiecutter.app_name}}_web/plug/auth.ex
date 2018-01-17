defmodule {{cookiecutter.app_name_camel_case}}Web.Plug.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _params) do
    assign(conn, :current_user, {{cookiecutter.app_name_camel_case}}.Guardian.Plug.current_resource(conn))
  end
end

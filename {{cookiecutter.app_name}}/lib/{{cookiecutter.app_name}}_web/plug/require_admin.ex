defmodule {{cookiecutter.app_name_camel_case}}Web.Plug.RequireAdmin do

  import Plug.Conn, only: [halt: 1]

  def init(opts), do: opts

  def call(conn, _params) do
    user = conn.assigns[:current_user]
    if user && user.admin do
      conn
    else
      conn
      |> Phoenix.Controller.render({{cookiecutter.app_name_camel_case}}Web.ErrorView, "404.html")
      |> halt()
    end
  end

end

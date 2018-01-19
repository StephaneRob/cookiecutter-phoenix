defmodule {{cookiecutter.app_name_camel_case}}Web.Plug.RedirectLoggedInUser do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]
  import {{cookiecutter.app_name_camel_case}}Web.Gettext
  alias {{cookiecutter.app_name_camel_case}}Web.Router

  @doc """
  Plug to redirect already logged in users.
  """
  def redirect_logged_in(conn, _params) do
    if {{cookiecutter.app_name_camel_case}}Web.AppHelpers.user_signed_in?(conn) do
      conn
      |> put_flash(:info, gettext("You are already connected."))
      |> redirect(to: Router.Helpers.home_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end

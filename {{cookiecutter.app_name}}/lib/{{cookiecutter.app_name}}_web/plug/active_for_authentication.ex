defmodule {{cookiecutter.app_name_camel_case}}Web.Plug.ActiveForAuthentication do
  @moduledoc """
    Sign out user automatically if no longer active for authentication
    ex : suspended
  """
  alias {{cookiecutter.app_name_camel_case}}.Accounts

  @doc false
  def init(opts), do: opts

  @doc false
  def call(conn, _) do
    user = conn.assigns[:current_user]
    case Accounts.active_for_authentication?(user) do
      {:ok, true} -> conn
      {reason, false} ->
        conn
        |> {{cookiecutter.app_name_camel_case}}.Guardian.Plug.sign_out
        |> Phoenix.Controller.put_flash(:error, {{cookiecutter.app_name_camel_case}}Web.Auth.humanize_reason(reason))
        |> Phoenix.Controller.redirect(to: {{cookiecutter.app_name_camel_case}}Web.Router.Helpers.home_path(conn, :index))
        |> Plug.Conn.halt()
    end
  end
end

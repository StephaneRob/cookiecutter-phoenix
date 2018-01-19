defmodule {{cookiecutter.app_name_camel_case}}Web.ConfirmationController do
  use {{cookiecutter.app_name_camel_case}}Web, :controller
  alias {{cookiecutter.app_name_camel_case}}.Accounts

  def edit(conn, %{"id" => confirmation_token}) do
    case Accounts.get_user_by(:confirmation_token, confirmation_token) do
      nil ->
        conn
        |> put_flash(:error, gettext("Invalid confirmation token"))
        |> redirect(to: home_path(conn, :index))

      user ->
        user
        |> Accounts.confirm_user()

        conn
        |> put_flash(:info, gettext("Your account has been successfully confirmed."))
        |> redirect(to: home_path(conn, :index))
    end
  end
end

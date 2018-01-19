defmodule {{cookiecutter.app_name_camel_case}}Web.RegistrationController do
  require Logger
  use {{cookiecutter.app_name_camel_case}}Web, :controller
  alias {{cookiecutter.app_name_camel_case}}.Accounts

  plug(:redirect_logged_in)
  plug(:scrub_params, "user" when action in [:create])

  def new(conn, _params) do
    changeset = Accounts.new_user(%Accounts.User{})
    render(conn, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Logger.debug("[CONFIRMATION] - #{confirmation_url(conn, :edit, user.confirmation_token)}")

        conn
        |> put_flash(:info, gettext("Account successfully created."))
        |> redirect(to: "/")

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Unable to create account"))
        |> render("new.html", changeset: changeset)
    end
  end
end

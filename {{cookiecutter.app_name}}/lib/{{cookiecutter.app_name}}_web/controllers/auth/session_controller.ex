defmodule {{cookiecutter.app_name_camel_case}}Web.SessionController do
  use {{cookiecutter.app_name_camel_case}}Web, :controller
  alias {{cookiecutter.app_name_camel_case}}.Accounts

  plug :redirect_logged_in when action in [:new, :create]

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    case Accounts.auth_by_email_and_password(session_params) do
      {:ok, user} ->
        case Accounts.active_for_authentication?(user) do
          {:ok, true} ->
            conn
            |> Accounts.sign_in(user)
            |> put_flash(:info, gettext("Successfully logged in."))
            |> redirect(to: home_path(conn, :index))
          {reason, false} ->
            conn
            |> put_flash(:error, {{cookiecutter.app_name_camel_case}}Web.Auth.humanize_reason(reason))
            |> redirect(to: session_path(conn, :new))
        end
      {:error, nil} ->
        conn
        |> put_flash(:error, gettext("Email or password invalid."))
        |> render("new.html")
      {:error, user} ->
        cond do
          user.failed_attempts < Application.get_env(:{{cookiecutter.app_name}}, :locked_after, 4) ->
            flash = gettext("Email or password invalid.")
          user.failed_attempts == Application.get_env(:{{cookiecutter.app_name}}, :locked_after, 4) ->
            flash = gettext("Il ne vous reste qu'une seule tentative avant le blocage de votre compte.")
          user.failed_attempts > Application.get_env(:{{cookiecutter.app_name}}, :locked_after, 4) ->
            flash = gettext("Votre compte est bloqué.")
        end

        conn
        |> put_flash(:error, flash)
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> {{cookiecutter.app_name_camel_case}}.Guardian.Plug.sign_out
    |> put_flash(:info, "See you soon !")
    |> redirect(to: "/")
  end
end

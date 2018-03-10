defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.SessionController do
  use {{cookiecutter.app_name.split('_')|map('title')|join}}Web, :controller
  alias {{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts

  plug({{cookiecutter.app_name.split('_')|map('title')|join}}Web.Plug.RequireGuest when action in [:new, :create])

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
            |> put_flash(:info, gettext("Signed in successfully."))
            |> redirect(to: home_path(conn, :index))

          {reason, false} ->
            conn
            |> put_flash(:error, {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Auth.humanize_reason(reason))
            |> redirect(to: session_path(conn, :new))
        end

      {:error, nil} ->
        conn
        |> put_flash(:error, gettext("Email or password invalid."))
        |> render("new.html")

      {:error, user} ->
        flash =
          cond do
            user.failed_attempts < Application.get_env(:my_app, :locked_after, 4) ->
              gettext("Email or password invalid.")

            user.failed_attempts == Application.get_env(:my_app, :locked_after, 4) ->
              gettext("You have one more attempt before your account is locked.")

            user.failed_attempts > Application.get_env(:my_app, :locked_after, 4) ->
              gettext("Your account is locked.")
          end

        conn
        |> put_flash(:error, flash)
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> {{cookiecutter.app_name.split('_')|map('title')|join}}.Guardian.Plug.sign_out()
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: "/")
  end
end

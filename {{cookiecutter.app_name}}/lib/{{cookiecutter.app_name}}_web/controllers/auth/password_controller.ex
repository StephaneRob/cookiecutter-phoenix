defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.PasswordController do
  use {{cookiecutter.app_name.split('_')|map('title')|join}}Web, :controller
  alias {{cookiecutter.app_name.split('_')|map('title')|join}}.{Accounts, Mailer}
  alias {{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts.User
  alias {{cookiecutter.app_name.split('_')|map('title')|join}}Web.AuthMailer

  plug({{cookiecutter.app_name.split('_')|map('title')|join}}Web.Plug.RequireGuest)

  def new(conn, _params) do
    changeset = Ecto.Changeset.change(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => reset_password_token}) do
    redirect(conn, to: password_path(conn, :edit, reset_password_token))
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    user = Accounts.get_user_by(:email, email)

    if user do
      Accounts.set_reset_password_token(user)
      AuthMailer.reset_password_instructions(user.id) |> Mailer.deliver_later
    end

    conn
    |> put_flash(
      :info,
      gettext(
        "If your email address exists in our database, you will receive an email with instructions for how to confirm your email address in a few minutes.."
      )
    )
    |> redirect(to: session_path(conn, :new))
  end

  def edit(conn, %{"id" => reset_password_token}) do
    case Accounts.get_user_by(:reset_password_token, reset_password_token) do
      nil ->
        conn
        |> put_flash(:error, gettext("Invalid token"))
        |> redirect(to: home_path(conn, :index))

      user ->
        changeset = Accounts.new_user_password(user)

        conn
        |> render("edit.html", changeset: changeset, id: user.reset_password_token)
    end
  end

  def update(conn, %{"user" => user_params}) do
    user = Accounts.get_user_by(:reset_password_token, user_params["reset_password_token"])

    if user do
      case Accounts.reset_password(user, user_params) do
        {:ok, _} ->
          Accounts.clean_reset_token(user)

          conn
          |> put_flash(:info, gettext("Password successfully changed"))
          |> redirect(to: session_path(conn, :new))

        {:error, changeset} ->
          conn
          |> render("edit.html", changeset: changeset, id: user.reset_password_token)
      end
    else
    end
  end
end

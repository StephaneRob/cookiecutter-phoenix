defmodule {{cookiecutter.app_name_camel_case}}Web.PasswordController do
  use {{cookiecutter.app_name_camel_case}}Web, :controller
  alias {{cookiecutter.app_name_camel_case}}.Accounts
  alias {{cookiecutter.app_name_camel_case}}.Accounts.User

  plug(:redirect_logged_in)

  def new(conn, _params) do
    changeset = Ecto.Changeset.change(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    case Accounts.get_user_by(:email, email) do
      nil ->
        changeset = Ecto.Changeset.change(%User{}, %{})

        conn
        |> put_flash(:error, gettext("Invalid email"))
        |> render("new.html", changeset: changeset)

      user ->
        Accounts.set_reset_password_token(user)

        conn
        |> put_flash(
          :info,
          gettext(
            "You will receive an email with instructions on how to reset your password in a few minutes."
          )
        )
        |> redirect(to: home_path(conn, :index))
    end
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

defmodule {{cookiecutter.app_name_camel_case}}.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias {{cookiecutter.app_name_camel_case}}.Repo

  alias {{cookiecutter.app_name_camel_case}}.Accounts.User

  # ----------------------------------
  # Fetch user(s)
  # ----------------------------------
  def list_users, do: Repo.all(User)

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by(attr, value), do: Repo.get_by(User, Map.new([{attr, value}]))
  def get_user_by!(attr, value), do: Repo.get_by!(User, Map.new([{attr, value}]))

  # ----------------------------------
  # Registrations
  # ----------------------------------
  def new_user(%User{} = user) do
    User.create_changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create_changeset(attrs)
    |> Repo.insert()
  end

  # ----------------------------------
  # Confirmations
  # ----------------------------------
  def confirmed_user?(%User{confirmed_at: nil}), do: false
  def confirmed_user?(%User{confirmed_at: _}), do: true

  def confirm_user(%User{} = user) do
    user
    |> Ecto.Changeset.change(%{confirmed_at: DateTime.utc_now, confirmation_token: nil})
    |> Repo.update()
  end

  # ----------------------------------
  # Sessions
  # ----------------------------------
  def auth_by_email_and_password(%{"login" => login, "password" => password}) do
    query = from u in User,
      where: fragment("lower(email) = lower(?) OR lower(name) = lower(?)", ^login, ^login)

    user = query
      |> first
      |> Repo.one

    if user do
      case authenticate(user, password) do
        true -> {:ok, user}
        false ->
          {_, user} = lock(user)
          {:error, user}
      end
    else
      IO.puts "JHJKHKJHKJHKJ"
      {:error, nil}
    end
  end

  defp authenticate(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
  end

  def sign_in(conn, %User{} = user) do
    conn
    |> {{cookiecutter.app_name_camel_case}}.Guardian.Plug.sign_in(user)
    |> track(user)
  end

  def track(conn, %User{} = user) do
    tracks = %{
      sign_in_count: user.sign_in_count + 1,
      current_sign_in_at: DateTime.utc_now,
      last_sign_in_at: user.current_sign_in_at,
      current_sign_in_ip: Enum.join(Tuple.to_list(conn.remote_ip), "."),
      last_sign_in_ip: user.current_sign_in_ip,
      failed_attempts: 0
    }
    user
    |> Ecto.Changeset.change(tracks)
    |> Repo.update()
    conn
  end

  # Lockable
  def lock(%User{} = user) do
    tracks = %{
      failed_attempts: user.failed_attempts + 1
    }

    if tracks[:failed_attempts] > Application.get_env(:{{cookiecutter.app_name}}, :locked_after, 4) do
      tracks = tracks
      |> Map.put(:unlock_token, User.generate_token(:unlock_token, 24))
      |> Map.put(:locked_at, DateTime.utc_now)
      # TODO - Add mailer to send unlock instruction
    end

    user
    |> Ecto.Changeset.change(tracks)
    |> Repo.update()
  end

  def active_for_authentication?(nil), do: {:ok, true}
  def active_for_authentication?(%User{confirmed_at: nil}), do: {:unconfirmed, false}
  def active_for_authentication?(%User{confirmed_at: _, suspended_at: nil, locked_at: nil}), do: {:ok, true}
  def active_for_authentication?(%User{confirmed_at: _, suspended_at: _, locked_at: nil}), do: {:suspended, false}
  def active_for_authentication?(%User{confirmed_at: _, suspended_at: _, locked_at: _}), do: {:locked, false}
  def active_for_authentication?(%User{}), do: {:ok, true}

  # ----------------------------------
  # Passwords
  # ----------------------------------
  def set_reset_password_token(%User{} = user) do
    user
    |> User.generate_reset_password_token()
    |> Repo.update()
  end

  def new_user_password(%User{} = user, attrs \\ %{}) do
    User.reset_password_changeset(user, attrs)
  end

  def reset_password(user, attrs \\ %{}) do
    user
    |> User.reset_password_changeset(attrs)
    |> User.set_password( )
    |> Repo.update()
  end

  def clean_reset_token(user) do
    user
    |> Ecto.Changeset.change(%{
        reset_password_sent_at: nil,
        reset_password_token: nil
      })
    |> Repo.update()
  end

end

defmodule {{cookiecutter.app_name_camel_case}}.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias {{cookiecutter.app_name_camel_case}}.{Repo, Accounts}

  alias {{cookiecutter.app_name_camel_case}}.Accounts.User

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :encrypted_password, :string
    field :suspended_at, :utc_datetime

    field :confirmation_token, :string
    field :confirmed_at, :utc_datetime
    field :confirmation_sent_at, :utc_datetime
    field :unconfirmed_email, :string # Only if using reconfirmable

    ## Recoverable
    field :reset_password_token, :string
    field :reset_password_sent_at, :utc_datetime

    ## Rememberable
    field :remember_created_at, :utc_datetime

    ## Trackable
    field :sign_in_count, :integer
    field :current_sign_in_at, :utc_datetime
    field :last_sign_in_at, :utc_datetime
    field :current_sign_in_ip, :string
    field :last_sign_in_ip, :string

    ## Lockable
    field :failed_attempts, :integer # Only if lock strategy is :failed_attempts
    field :unlock_token, :string # Only if unlock strategy is :email or :both
    field :locked_at, :utc_datetime

    timestamps()
  end

  @doc false
  def create_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unsafe_validate_unique(:name, Repo)
    |> unsafe_validate_unique(:email, Repo)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$\z/i)
    |> encrypt_password()
    |> put_change(:confirmation_token, generate_token(:confirmation_token))
    |> put_change(:confirmation_sent_at, DateTime.utc_now)
  end

  defp encrypt_password(changeset) do
     put_change(changeset, :encrypted_password, hash_password(changeset.changes[:password]))
   end

  defp hash_password(password) when password in ["", nil], do: nil
  defp hash_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end

  def generate_token(token_name, length \\ 24) do
    token = length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, length)

    case Accounts.get_user_by(token_name, token) do
      nil -> token
      _ -> generate_token(token_name, length)
    end
  end

  def generate_reset_password_token(%User{} = user) do
    user
    |> change(%{
        reset_password_sent_at: DateTime.utc_now,
        reset_password_token: generate_token(:reset_password_token, 24)
      })
  end

  def reset_password_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_confirmation(:password)
  end

  def set_password(changeset) do
    changeset
    |> encrypt_password()
  end
end

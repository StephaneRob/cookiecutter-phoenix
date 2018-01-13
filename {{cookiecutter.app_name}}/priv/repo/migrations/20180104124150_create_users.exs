defmodule {{cookiecutter.app_name_camel_case}}.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :encrypted_password, :string
      add :suspended_at, :utc_datetime

      ## Confirmable
      add :confirmation_token, :string
      add :confirmed_at, :utc_datetime
      add :confirmation_sent_at, :utc_datetime
      add :unconfirmed_email, :string

      ## Recoverable
      add :reset_password_token, :string
      add :reset_password_sent_at, :utc_datetime

      ## Rememberable
      add :remember_created_at, :utc_datetime

      ## Trackable
      add :sign_in_count, :integer, default: 0, null: false
      add :current_sign_in_at, :utc_datetime
      add :last_sign_in_at, :utc_datetime
      add :current_sign_in_ip, :string
      add :last_sign_in_ip, :string

      ## Lockable
      add :failed_attempts, :integer, default: 0, null: false
      add :unlock_token, :string
      add :locked_at, :utc_datetime

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:name])
    create unique_index(:users, [:confirmation_token])
    create unique_index(:users, [:unlock_token])
    create unique_index(:users, [:reset_password_token])
  end
end

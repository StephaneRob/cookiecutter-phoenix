defmodule {{cookiecutter.app_name_camel_case}}.GuardianSerializer do
  @behaviour Guardian.Serializer
  alias {{cookiecutter.app_name_camel_case}}.Accounts

  def for_token(user = %Accounts.User{}) do
    { :ok, "User:#{user.id}" }
  end
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Accounts.get_user!(id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end

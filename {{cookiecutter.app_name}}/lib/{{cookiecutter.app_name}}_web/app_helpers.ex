defmodule {{cookiecutter.app_name_camel_case}}Web.AppHelpers do
  def current_user(conn), do: conn.assigns[:current_user]

  def user_signed_in?(conn), do: !!current_user(conn)

  def admin?(conn), do: user_signed_in?(conn) && current_user(conn).admin
end

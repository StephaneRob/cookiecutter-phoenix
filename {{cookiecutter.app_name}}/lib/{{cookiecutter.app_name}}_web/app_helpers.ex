defmodule {{cookiecutter.app_name_camel_case}}Web.AppHelpers do
  def current_user(conn), do: conn.assigns[:current_user]

  def user_signed_in?(conn), do: !!current_user(conn)
end

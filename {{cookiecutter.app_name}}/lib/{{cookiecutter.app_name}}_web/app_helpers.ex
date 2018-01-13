defmodule {{cookiecutter.app_name_camel_case}}Web.AppHelpers do
  def current_user(conn), do: Guardian.Plug.current_resource(conn)

  def user_signed_in?(conn), do: !!current_user(conn)
end

defmodule {{cookiecutter.app_name_camel_case}}Web.AppHelpers do
  def current_user(conn), do: conn.assigns[:current_user]

  def user_signed_in?(conn), do: !!current_user(conn)

  def admin?(conn), do: user_signed_in?(conn) && current_user(conn).admin

  def format_datime(datetime), do: format_datime(datetime, :date)
  def format_datime(datetime, :date), do: Timex.format!(datetime, "%Y-%m-%d", :strftime)
  def format_datime(datetime, :pretty), do: Timex.format!(datetime, "%B, %d %Y at %Hh%M", :strftime)
end

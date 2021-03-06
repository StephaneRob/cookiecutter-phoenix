defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.AppHelpers do
  def current_user(conn), do: conn.assigns[:current_user]

  def user_signed_in?(conn), do: !!current_user(conn)

  def admin?(conn), do: user_signed_in?(conn) && current_user(conn).admin

  def format_datetime(datetime), do: format_datetime(datetime, :date)
  def format_datetime(datetime, :date), do: Timex.format!(datetime, "%Y-%m-%d", :strftime)
  def format_datetime(datetime, :pretty), do: Timex.format!(datetime, "%B, %d %Y at %Hh%M", :strftime)
end

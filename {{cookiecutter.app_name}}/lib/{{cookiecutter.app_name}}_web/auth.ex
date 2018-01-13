defmodule {{cookiecutter.app_name_camel_case}}Web.Auth do
  import {{cookiecutter.app_name_camel_case}}Web.Gettext

  def humanize_reason(:unconfirmed), do: gettext("Your account is not confirmed.")
  def humanize_reason(:suspended), do: gettext("Your account has been suspended.")
  def humanize_reason(:locked), do: gettext("Your account has been locked.")
end

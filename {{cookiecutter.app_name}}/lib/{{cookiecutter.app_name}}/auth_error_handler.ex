defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}.Guardian.AuthErrorHandler do
  def auth_error(_conn, _type_reason, _opts) do
  end
end

defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Plug.BrowserAuth do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :my_app,
    module: {{cookiecutter.app_name.split('_')|map('title')|join}}.Guardian,
    error_handler: {{cookiecutter.app_name.split('_')|map('title')|join}}.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifySession, claims: @claims)
  plug(Guardian.Plug.LoadResource, allow_blank: true)
  plug({{cookiecutter.app_name.split('_')|map('title')|join}}Web.Plug.Auth)
  plug({{cookiecutter.app_name.split('_')|map('title')|join}}Web.Plug.ActiveForAuthentication)
end

defmodule {{cookiecutter.app_name_camel_case}}Web.Plug.BrowserAuth do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline, otp_app: :my_app,
    module: {{cookiecutter.app_name_camel_case}}.Guardian,
    error_handler: {{cookiecutter.app_name_camel_case}}.Guardian.AuthErrorHandler

  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug {{cookiecutter.app_name_camel_case}}Web.Plug.ActiveForAuthentication
end

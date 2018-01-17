defmodule {{cookiecutter.app_name_camel_case}}Web.Admin.UserController do
  use {{cookiecutter.app_name_camel_case}}Web, :controller
  alias {{cookiecutter.app_name_camel_case}}.Accounts
  import Ecto.Query, warn: false

  def index(conn, params) do
    render(conn, "index.html", users: Accounts.paginated_users(params))
  end
end

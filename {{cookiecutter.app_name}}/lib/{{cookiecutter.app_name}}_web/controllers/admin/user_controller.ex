defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Admin.UserController do
  use {{cookiecutter.app_name.split('_')|map('title')|join}}Web, :controller
  alias {{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts
  import Ecto.Query, warn: false

  def index(conn, params) do
    render(conn, "index.html", users: Accounts.paginated_users(params))
  end
end

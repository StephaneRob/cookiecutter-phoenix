defmodule {{cookiecutter.app_name_camel_case}}Web.HomeController do
  use {{cookiecutter.app_name_camel_case}}Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

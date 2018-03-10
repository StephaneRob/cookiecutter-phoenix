defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.HomeController do
  use {{cookiecutter.app_name.split('_')|map('title')|join}}Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.PageControllerTest do
  use {{cookiecutter.app_name.split('_')|map('title')|join}}Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end

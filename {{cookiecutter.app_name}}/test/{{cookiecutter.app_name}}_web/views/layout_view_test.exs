defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.LayoutViewTest do
  use {{cookiecutter.app_name.split('_')|map('title')|join}}Web.ConnCase, async: true
end

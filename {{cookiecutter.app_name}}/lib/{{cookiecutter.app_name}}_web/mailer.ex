defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.Mailer do
  use Bamboo.Mailer, otp_app: :{{cookiecutter.app_name}}
end

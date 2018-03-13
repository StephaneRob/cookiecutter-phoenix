defmodule {{cookiecutter.app_name.split('_')|map('title')|join}}Web.AuthMailer do
  use Bamboo.Phoenix, view: {{cookiecutter.app_name.split('_')|map('title')|join}}Web.AuthMailerView
  alias {{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts

  def confirmation_instructions(user_id) do
    user = Accounts.get_user!(user_id)

    new_email()
    |> to({user.name, user.email})
    |> from("site@example.com")
    |> subject("Confirmation instructions")
    |> put_layout({% raw %}{{% endraw %}{{cookiecutter.app_name.split('_')|map('title')|join}}Web.LayoutView, :mailer{% raw %}}{% endraw %})
    |> render(:confirmation_instructions, %{user: user})
  end

  def reset_password_instructions(user_id) do
    user = Accounts.get_user!(user_id)

    new_email()
      |> to({user.name, user.email})
      |> from("site@example.com")
      |> subject("Reset password instructions")
      |> put_layout({% raw %}{{% endraw %}{{cookiecutter.app_name.split('_')|map('title')|join}}Web.LayoutView, :mailer{% raw %}}{% endraw %})
      |> render(:reset_password_instructions, %{user: user})
  end
end

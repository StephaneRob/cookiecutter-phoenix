users = [
  %{{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts.User{
    name: "admin",
    # azerty
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS",
    email: "admin@example.com",
    confirmed_at: Timex.now(),
    admin: true
  },
  %{{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts.User{
    name: "user",
    # azerty
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS",
    email: "user@example.com",
    confirmed_at: Timex.now()
  },
  %{{cookiecutter.app_name.split('_')|map('title')|join}}.Accounts.User{
    name: "locked_user",
    # azerty
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS",
    email: "locked_user@example.com",
    confirmed_at: Timex.now(),
    locked_at: Timex.now()
  }
]

for user <- users do
  {{cookiecutter.app_name.split('_')|map('title')|join}}.Repo.insert!(user)
end

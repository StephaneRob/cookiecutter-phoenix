users = [
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "admin",
    # azerty
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS",
    email: "admin@example.com",
    confirmed_at: DateTime.utc_now(),
    admin: true
  },
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "user",
    # azerty
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS",
    email: "user@example.com",
    confirmed_at: DateTime.utc_now()
  },
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "locked_user",
    # azerty
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS",
    email: "locked_user@example.com",
    confirmed_at: DateTime.utc_now(),
    locked_at: DateTime.utc_now()
  }
]

for user <- users do
  {{cookiecutter.app_name_camel_case}}.Repo.insert!(user)
end

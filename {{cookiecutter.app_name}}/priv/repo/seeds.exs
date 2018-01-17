users = [
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "admin",
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS", # azerty
    email: "admin@example.com",
    confirmed_at: DateTime.utc_now,
    admin: true
  },
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "user",
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS", # azerty
    email: "user@example.com",
    confirmed_at: DateTime.utc_now
  },
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "locked_user",
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS", # azerty
    email: "locked_user@example.com",
    confirmed_at: DateTime.utc_now,
    locked_at: DateTime.utc_now
  }
]

for user <- users do
  {{cookiecutter.app_name_camel_case}}.Repo.insert!(user)
end

{{cookiecutter.app_name_camel_case}}.Repo.insert!(
  %{{cookiecutter.app_name_camel_case}}.Accounts.User{
    name: "admin",
    encrypted_password: "$2b$12$M3r3PZSHcunEFCxxzd75u.OkSj300ZDDKJUl/H24Hpq5aOvlyqHXS", # azerty
    email: "admin@example.com",
    confirmed_at: DateTime.utc_now,
    admin: true
  }
)

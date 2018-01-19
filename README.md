# Cookiecutter-phoenix (WIP)

A [cookiecutter](https://github.com/audreyr/cookiecutter) template to bootstrap an [Elixir](https://elixir-lang.org/)/[Phoenix](http://phoenixframework.org/) web app.

## Prerequisities

- Python 3.6
- Elixir 1.6
- Postgresql >= 9.6

## Features

- Elixir 1.6
- Phoenix 1.3
- Authentication : Authenticable, registerable, trackable, confirmable, lockable, recoverable (guardian, comeonin, bcrypt)
- Twitter Bootstrap 4
- Slime template

## Usage

Install cookiecutter

```
pip install cookiecutter
```

Run cookiecutter against the repo

```
cookiecutter https://github.com/StephaneRob/cookiecutter-phoenix
```

You'll be prompted for some values to configure your Phoenix app

```
app_name [myapp]: my_app
app_name_camel_case [MyApp]:
domain_name [example.com]:
author_name [Stéphane ROBINO]:
email [you@example.com]:
description [A short description of the project.]:
version [0.0.1]:
dev_database_name [my_app_dev]:
dev_database_username []:
dev_database_password []:
test_database_name [my_app_test]:
test_database_username []:
test_database_password []:
```

Steps after configuration :

1. Generate a phoenix app
2. Initiate a git repo and commit an 'Initial commit'
3. Install elixir dependencies
4. Create database and migrate
5. Install assets dependencies

You're ready to start server `cd myapp && mix phx.server`

## Todo

### Cookiecutter
- [ ] Remove `app_name_camel_case` shouldn't be configurable
- [ ] Configuration options
  - [ ] https
- [ ] Generate secrets on post_gen_project hook

### APP
- [ ] Add mailer dependency (bamboo, mailman, swoosh)
  - [ ] Add authentication email
- [ ] Add ueberauth ?
- [ ] Add deployment tool : [distillery](https://github.com/bitwalker/distillery)/[bootleg](https://github.com/labzero/bootleg)

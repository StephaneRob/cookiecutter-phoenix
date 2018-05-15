# Cookiecutter-phoenix (WIP)

A [cookiecutter](https://github.com/audreyr/cookiecutter) template to bootstrap an [Elixir](https://elixir-lang.org/)/[Phoenix](http://phoenixframework.org/) web app.

## Prerequisities

- Python 3.6
- Elixir 1.6
- Postgresql >= 9.6 OR Mysql >= 5.7

## Features

- Elixir 1.6
- Phoenix 1.3
- Authentication : Authenticable, registerable, trackable, confirmable, lockable, recoverable (guardian, comeonin, bcrypt)
- Tailwindcss
- Font awesome 5

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
app_name (lowercase) [my_app]: my_app
domain_name [example.com]:
author_name [Stéphane ROBINO]:
email [you@example.com]:
description [A short description of the project.]:
version [0.0.1]:
Select database:
1 - postgresql
2 - mysql
Choose from 1, 2 [1]:
dev_database_name [my_app_dev]:
dev_database_username []:
dev_database_password []:
test_database_name [my_app_test]:
test_database_username []:
test_database_password []:
Select database_setup:
1 - setup
2 - migrate
3 - none
Choose from 1, 2, 3 [1]:
```

Steps after configuration :

1. Generate a phoenix app
2. Initiate a git repo and commit an 'Initial commit'
3. Install elixir dependencies
4. Create database and migrate
5. Install assets dependencies

You're ready to start server `cd myapp && iex -S mix phx.server`

#!/bin/sh

$RELEASE_ROOT_DIR/bin/{{cookiecutter.app_name}} command Elixir.{{cookiecutter.app_name.split('_')|map('title')|join}}.ReleaseTasks migrate

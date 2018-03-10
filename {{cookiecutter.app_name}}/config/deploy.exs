use Bootleg.Config

after_task :clean do
  remote :build do
    "mkdir -p /home/stephane/builds/config"
    "mkdir -p /home/stephane/builds/assets"
    "ln -s /home/stephane/shared/prod.secret.exs /home/stephane/builds/config/prod.secret.exs"
    "ln -s /home/stephane/shared/_build/ /home/stephane/builds"
    "ln -s /home/stephane/shared/deps/ /home/stephane/builds"
    "ln -s /home/stephane/shared/assets/node_modules/ /home/stephane/builds/assets"
  end
end

before_task :start do
  remote :app do
    "bin/app_test migrate"
  end
end

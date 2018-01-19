use Bootleg.Config

role(:build, "build.example.com", workspace: "/tmp/bootleg/build")

after_task :clean do
  remote :build do
    "mkdir -p /home/admin/releases/config/"
    "ln -s /home/admin/shared/prod.secret.exs /home/admin/releases/config/prod.secret.exs"
  end
end

task :phoenix_digest do
  mix_env = Keyword.get(config(), :mix_env, "prod")

  remote :build, cd: "assets" do
    "npm install"
    "./node_modules/brunch/bin/brunch b -p"
  end

  remote :build do
    "MIX_ENV=#{mix_env} mix phoenix.digest"
  end
end

after_task(:compile, :phoenix_digest)

before_task :start do
  remote :app do
    "bin/#{Config.app()} migrate"
  end
end

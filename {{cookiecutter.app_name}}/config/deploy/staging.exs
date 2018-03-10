use Bootleg.Config

role(:build, "46.101.140.16", workspace: "builds", user: "stephane", identity: "/Users/stephanerobino/.ssh/digital-ocean", release_workspace: "/home/stephane")
role(:app, "46.101.140.16", workspace: "public_html", user: "stephane", identity: "/Users/stephanerobino/.ssh/digital-ocean", release_workspace: "/home/stephane")

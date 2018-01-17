defmodule {{cookiecutter.app_name_camel_case}}Web.Router do
  use {{cookiecutter.app_name_camel_case}}Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug {{cookiecutter.app_name_camel_case}}Web.Plug.Turbolinks
  end

  pipeline :browser_auth do
    plug {{cookiecutter.app_name_camel_case}}Web.Plug.BrowserAuth
  end

  pipeline :admin do
    plug {{cookiecutter.app_name_camel_case}}Web.Plug.RequireAdmin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", {{cookiecutter.app_name_camel_case}}Web do
    pipe_through [:browser, :browser_auth]

    scope "/admin", Admin, as: :admin do
      pipe_through [:admin]

      resources "/user", UserController, only: [:index]
    end

    # Authenticable
    get    "/sign_in",  SessionController, :new
    post   "/sign_in",  SessionController, :create
    delete "/sign_out", SessionController, :delete

    # Confirmation
    resources "/confirmations", ConfirmationController, only: [:edit]

    # Password
    resources "/passwords", PasswordController, only: [:new, :create, :edit, :update]

    # Registration
    get "/sign_up", RegistrationController, :new
    post "/sign_up", RegistrationController, :create

    get "/", HomeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", {{cookiecutter.app_name_camel_case}}Web do
  #   pipe_through :api
  # end
end

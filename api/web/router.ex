defmodule Sling.Router do
  use Sling.Web, :router

  # . Plugs are like functions that each request will pipe through
  # similar to a Rails before_action
  pipline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource

  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Sling do
    pipe_through :browser

    get "/", PageController, :index
  end



  scope "/api", Sling do
    pipe_through :api


    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, only: [:create]
  end
end

defmodule YourAppWeb.Router do
  use YourAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", YourAppWeb do
    pipe_through :api
    # Your routes here
  end
end
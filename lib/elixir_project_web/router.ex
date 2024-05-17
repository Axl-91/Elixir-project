defmodule ElixirProjectWeb.Router do
  use ElixirProjectWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirProjectWeb do
    pipe_through :api
  end
end

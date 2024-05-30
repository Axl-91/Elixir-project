defmodule ElixirProjectWeb.Router do
  use ElixirProjectWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug ElixirProjectWeb.Auth.Pipeline
    plug ElixirProjectWeb.Auth.SetAccount
  end

  scope "/api", ElixirProjectWeb do
    pipe_through :api

    get "/", DefaultController, :index
    post "/accounts/create", AccountController, :create
    post "/accounts/sign_in", AccountController, :sign_in
  end

  scope "/api", ElixirProjectWeb do
    pipe_through [:api, :auth]

    get "/account/:id", AccountController, :show
    post "/account/update", AccountController, :update
    get "/accounts/sign_out", AccountController, :sign_out
    get "/accounts/refresh_session", AccountController, :refresh_session
    delete "/account/delete/:id", AccountController, :delete
    post "/users/update", UserController, :update
  end
end

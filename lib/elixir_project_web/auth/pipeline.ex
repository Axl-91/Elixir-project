defmodule ElixirProjectWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :elixir_project,
    module: ElixirProjectWeb.Auth.Guardian,
    error_handler: ElixirProjectWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end

defmodule ElixirProject.Repo do
  use Ecto.Repo,
    otp_app: :elixir_project,
    adapter: Ecto.Adapters.Postgres
end

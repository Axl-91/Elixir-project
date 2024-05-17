defmodule ElixirProjectWeb.DefaulController do
  use ElixirProjectWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to Elixir-project")
  end

end

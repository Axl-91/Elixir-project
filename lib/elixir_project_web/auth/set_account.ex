defmodule ElixirProjectWeb.Auth.SetAccount do
  alias ElixirProjectWeb.Auth.ErrorResponse
  alias ElixirProject.Accounts
  import Plug.Conn

  def init(_options) do
  end

  def call(conn, _options) do
    if conn.assigns[:account] do
      conn
    else
      account_id = get_session(conn, :account_id)

      set_account_session(conn, account_id)
    end
  end

  defp set_account_session(_, nil), do: raise(ErrorResponse.Unauthorized)

  defp set_account_session(conn, account_id) do
    account = Accounts.get_account(account_id)
    assign(conn, :account, account)
  end
end

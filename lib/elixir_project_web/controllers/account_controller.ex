defmodule ElixirProjectWeb.AccountController do
  use ElixirProjectWeb, :controller

  alias ElixirProject.Users
  alias ElixirProject.Users.User
  alias ElixirProjectWeb.Auth.Guardian
  alias ElixirProject.Accounts
  alias ElixirProject.Accounts.Account

  import ElixirProjectWeb.Auth.AuthorizedPlug
  plug :is_authorized when action in [:update, :delete]

  action_fallback ElixirProjectWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["hash_password"])
    end
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    authorize_account(conn, email, hash_password)
  end

  defp authorize_account(conn, email, hash_password) do
    with {:ok, account, token} <- Guardian.authenticate(email, hash_password) do
      conn
      |> put_session(:account_id, account.id)
      |> put_status(:ok)
      |> render(:account_token, %{account: account, token: token})
    end
  end

  def refresh_session(conn, %{}) do
    old_token = Guardian.Plug.current_token(conn)

    case Guardian.authenticate(old_token) do
      {:ok, account, new_token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:account_token, %{account: account, token: new_token})

      {:error, _reason} ->
        {:error, :not_found}
    end
  end

  def sign_out(conn, _params) do
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)

    conn
    |> clear_session()
    |> put_status(:ok)
    |> render(:account_token, %{account: account, token: nil})
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"account" => account_params}) do
    account = Accounts.get_account!(account_params["id"])

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end

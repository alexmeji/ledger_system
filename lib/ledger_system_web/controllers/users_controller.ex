defmodule LedgerSystemWeb.UsersController do
  use Phoenix.Controller, formats: [:json]
  require Logger
  alias LedgerSystem.Users
  alias LedgerSystem.Users.User
  alias LedgerSystem.Accounts
  alias LedgerSystem.Accounts.Account

  def list(conn, _params) do
    users = %{users: Users.list_users()}
    render(conn, :list, users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show_with_account, user: user)
  end

  def create(conn, %{"name" => name, "email" => email, "password" => password}) do
    with {:ok, %User{} = user} <-
           Users.create_user(%{name: name, email: email, password: password}),
         {:ok, %Account{} = _account} <-
           Accounts.create_account(%{"user_id" => user.id, "balance" => 0}) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    else
      {:error, %Ecto.Changeset{} = _changeset} ->
        raise Plug.BadRequestError, plug_status: 400
    end
  end
end

defmodule LedgerSystemWeb.UsersJSON do
  alias LedgerSystem.Users.User

  def list(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%{user: user}) do
    %{data: data(user)}
  end

  def show_with_account(%{user: user}) do
    %{data: data_with_account(user)}
  end

  defp data_with_account(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      accounts:
        Enum.map(user.accounts, fn account ->
          %{"account" => account.id, "balance" => account.balance}
        end)
    }
  end

  defp data(%User{} = data) do
    %{
      id: data.id,
      name: data.name,
      email: data.email
    }
  end
end

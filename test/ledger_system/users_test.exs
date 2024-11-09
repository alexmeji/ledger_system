defmodule LedgerSystem.UsersTest do
  @moduledoc false

  use LedgerSystem.DataCase

  alias LedgerSystem.Users

  def create_user_fixture do
    {:ok, user} =
      Users.create_user(%{
        name: "Alex",
        email: "me@me.com",
        password: "password"
      })

    user
  end

  describe "users" do
    test "create_user/1 creates a user" do
      user = create_user_fixture()
      assert user.name == "Alex"
    end

    test "create_user/1 fails with invalid attributes" do
      user = Users.create_user(%{name: "Alice", email: nil, password: "password"})
      assert {:error, %Ecto.Changeset{}} = user
    end

    test "create_user/0 fails with empty attributes" do
      user = Users.create_user()
      assert {:error, %Ecto.Changeset{}} = user
    end

    test "get_user/1 returns the user with given id" do
      user = create_user_fixture()
      user_fetched = Users.get_user!(user.id)
      assert user_fetched.id == user.id
    end

    test "list_users/0 returns all users" do
      create_user_fixture()
      assert length(Users.list_users()) == 1
    end

    test "update_uses/1 updates the user" do
      user = create_user_fixture()
      {:ok, updated_user} = Users.update_user(user, %{name: "Sergio"})
      assert updated_user.name == "Sergio"
    end

    test "delete_user/1 deletes the user" do
      user = create_user_fixture()
      assert Users.delete_user(user)
      assert Enum.empty?(Users.list_users())
    end

    test "change_user/2" do
      user = create_user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end

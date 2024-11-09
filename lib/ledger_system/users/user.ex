defmodule LedgerSystem.Users.User do
  @moduledoc """
  The User schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:name, :string)
    field(:password, :string)
    field(:email, :string)
    has_many(:accounts, LedgerSystem.Accounts.Account)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
  end
end

defmodule LedgerSystem.Transactions.Transaction do
  @moduledoc """
  The transaction schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field(:type, Ecto.Enum, values: [:debit, :credit])
    field(:amount, :decimal)
    belongs_to(:account, LedgerSystem.Accounts.Account)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:account_id, :amount, :type])
    |> validate_required([:amount, :type])
  end
end

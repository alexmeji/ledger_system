# This file is used to setup and manage the test data for the ledger application

defmodule LedgerApp.Support.DataCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      alias LedgerApp.Repo

      import Ecto
      import Ecto.Query
      import LedgerApp.Support.DataCase

      # The default endpoint for testing
      @endpoint LedgerAppWeb.Endpoint
    end
  end

  # Your code here
end
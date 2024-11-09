defmodule LedgerSystemWeb.Router do
  use LedgerSystemWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", LedgerSystemWeb do
    pipe_through(:api)
    # Your routes here
    get("/users", UsersController, :list)
    post("/users", UsersController, :create)

    post("/credit", TransactionsController, :credit)
    post("/debit", TransactionsController, :debit)

    get("/balance/:id", UsersController, :show)
  end
end

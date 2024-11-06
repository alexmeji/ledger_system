

## Objective

Your task is to create an Elixir/Phoenix application that provides a basic ledger system able to handle financial transactions. The application should also incorporate real-time updates of account balances using Phoenix.PubSub.

## Brief

In this challenge, your goal is to implement a ledger system that allows a user to perform debit and credit operations on an account. The system should track all transactions and provide the account balance at any given time. You will also need to use Phoenix.PubSub to push real-time updates of account balances.

### Task 1: Set up the Elixir/Phoenix project

Begin by setting up a new Elixir/Phoenix project. Ensure your environment is properly configured and all necessary dependencies are installed.

### Task 2: Building the Database Schema

Create a PostgreSQL database schema with the following tables:

- Users: id, name, email, password
- Accounts: id, user_id, balance
- Transactions: id, account_id, amount, type (debit or credit), timestamp

Ensure appropriate relationships are established between the tables.

### Task 3: Implementing the Business Logic

Implement the following functionalities:

- A function that creates a new user and an associated account with an initial balance of zero.
- A function that takes a user id and an amount, and credits that amount to the user's account.
- A function that takes a user id and an amount, and debits that amount from the user's account.
- A function that takes a user id and returns the current balance of the user's account.
- All transactions should be recorded in the Transactions table.

### Task 4: Implementing the API Endpoints

Expose the following API endpoints using Phoenix:

- POST /users: Creates a new user
- POST /credit: Credits an amount to a user's account
- POST /debit: Debits an amount from a user's account
- GET /balance: Returns the current balance of a user's account

### Task 5: Implement Real-Time Updates with Phoenix.PubSub

Use Phoenix.PubSub to publish updates whenever a transaction is made. Any time a user's balance changes, the new balance should be published to a topic unique to the user.

### Task 6: Implementing Concurrency with GenServer

Leverage the power of GenServer to handle multiple requests simultaneously.

### Task 7: Implementing Supervision and Fault Tolerance Strategies

Implement supervision strategies to make your application resilient. This should ensure that your system can recover from failures and continue to function.

### Testing Requirements

Your application should be fully tested. Use ExUnit to write tests for all your functions and API endpoints.

### Code Quality Requirements

Use `mix format` for formatting, and Dialyzer and Credo for static code analysis to ensure your code is of the highest quality.

### Evaluation Criteria

- **Elixir Best Practices**: Is the code idiomatic, easily readable, and well-organized?
- **Testing**: Are all the functions/API endpoints adequately tested?
- **Correctness**: Does the application do what was asked?
- **Error Handling**: Does the code gracefully handle potential errors?
- **Concurrency**: Is GenServer effectively used to handle concurrent operations?
- **Fault Tolerance**: Are the right supervision strategies implemented to handle failures?
- **Real-Time Updates**: Are real-time updates properly pushed through Phoenix.PubSub?
- **Code Quality**: Is the code well-formatted? Does it pass Dialyzer and Credo checks?

### CodeSubmit 

Please organize, design, test, and document your code as if it were going into production - then push your changes to the master branch.

Enjoy the challenge and happy coding! 🚀

The Jobsity LLC Team


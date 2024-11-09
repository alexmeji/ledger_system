# Solution

### Task 1: Set up the Elixir/Phoenix project

To have the latest Phoenix features I just update to the latest version and adapt the project to follow the Phoenix project recommendations. The additional changes I make is to use Bandit instead of Cowboy, Bandit has a better interface to deal with the JSON response and is faster than Cowboy. You can see the change of the adapter in the config file.

### Task 2: Building the Database Schema

To create the schema, I use the Phoenix generators to create the Repo, Schema and for the migrations I remove the files created with the generator and use the default files that the project has.

These are the commands I use:

```
mix phx.gen.context Users User users name:string email:string:unique password:string
```

```
mix phx.gen.context Accounts Account accounts user_id:references:users balance:decimal
```

```
mix phx.gen.context Transactions Transaction transactions account_id:references:accounts amount:decimal type:enum:debit:credit
```

### Task 3: Implementing the Business Logic

To create the business logic to run over time (my bad, I just start doing this on Friday at 8 PM), I use the controllers to create the Users+Accounts. A better solution is to add a Service Layer to deal with the Repository calls and separate the Business Logic from the controller.

To make the logic work with the debit/credit function, I create the Business Logic inside the UpdateBalance.Worker, which is a GenServer that does this update in the background.

### Task 4: Implementing the API Endpoints

All the routes created with the requirement in the README file.

### Task 5: Implement Real-Time Updates with Phoenix.PubSub

For this requirement you can see the PubSub broadcast implementation in the UpdateBalance.Worker, where I simply send a message in 2 topics “users:#{id}” and “balance_updated”, where the first topic is more personal to only read updates per user and the second is a global topic that everyone can listen to.

To test the subscription, you can look at the BalanceWatcher module, which is a GenServer that is listening for the message in the global topic.

### Task 6: Implementing Concurrency with GenServer

To implement Concurrency with GenServers I create as an example the UpdateBalance.Worker, where you can see that we can work asynchronously modifying the balance in the database. 

A good recommendation to work with this in production is to use Oban Jobs, which is a GenServer inside which we can have a lot of Workers doing the work in the background.

### Task 7: Implementing Supervision and Fault Tolerance Strategies

For this task, I use the :one_for_one strategy, so that I can recover the application and the child process if one of these exits.

### Testing Requirements

I test for the necessary files and indeed the project has 88.32% coverage.

The only change I recommend is to assert the background call to GenServer in the controller test. I recommend using the assert_receive to wait for the response from the GenServer task.

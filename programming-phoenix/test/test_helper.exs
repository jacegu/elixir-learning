ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ProgrammingPhoenix.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ProgrammingPhoenix.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ProgrammingPhoenix.Repo)


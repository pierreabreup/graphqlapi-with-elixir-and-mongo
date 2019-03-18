defmodule Lrmi.DataCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Lrmi.Repo

      import Ecto
      import Ecto.Changeset
      import Lrmi.DataCase
      import Lrmi.Factory
    end
  end

  setup tags do

    Mongo.delete_many(:mongo, "creative_works", %{}, pool: DBConnection.Poolboy)
    {:ok, []}
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end

defmodule Lrmi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    database_config = Application.get_env(:lrmi, :db_config)
    children = [
      # Start the Ecto repository
      # Start the endpoint when the application starts
      LrmiWeb.Endpoint,
      %{
        id: Mongo,
        start: { Mongo, :start_link, [database_config] }
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lrmi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LrmiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

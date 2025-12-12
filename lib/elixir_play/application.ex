defmodule ElixirPlay.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirPlayWeb.Telemetry,
      ElixirPlay.Repo,
      {DNSCluster, query: Application.get_env(:elixir_play, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirPlay.PubSub},
      # Start a worker by calling: ElixirPlay.Worker.start_link(arg)
      # {ElixirPlay.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirPlayWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirPlay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirPlayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

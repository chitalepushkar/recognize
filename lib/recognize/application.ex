defmodule Recognize.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RecognizeWeb.Telemetry,
      Recognize.Repo,
      {DNSCluster, query: Application.get_env(:recognize, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Recognize.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Recognize.Finch},
      # Start a worker by calling: Recognize.Worker.start_link(arg)
      # {Recognize.Worker, arg},
      # Start to serve requests, typically the last entry
      RecognizeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Recognize.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RecognizeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

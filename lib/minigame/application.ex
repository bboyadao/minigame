defmodule Minigame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  Supervisor.Spec
  
  use Application
  use KafkaEx.GenConsumer

  def start(_type, _args) do
    import Supervisor.Spec

    consumer_group_opts = [
      # setting for the ConsumerGroup
      heartbeat_interval: 1_000,
      # this setting will be forwarded to the GenConsumer
      commit_interval: 1_000
    ]
    gen_consumer_impl = GenConsumer
    consumer_group_name = "example_group"
    topic_names = ["example_topic"]

    children = [
      # Start the Ecto repository
      Minigame.Repo,
      # Start the Telemetry supervisor
      MinigameWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Minigame.PubSub},
      # Start the Endpoint (http/https)
      MinigameWeb.Endpoint,
      # Start a worker by calling: Minigame.Worker.start_link(arg)
      # {Minigame.Worker, arg}

      supervisor(
        KafkaEx.ConsumerGroup,
        [gen_consumer_impl, consumer_group_name, topic_names, consumer_group_opts]
      )

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Minigame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MinigameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

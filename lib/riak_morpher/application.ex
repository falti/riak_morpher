defmodule RiakMorpher.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  require Logger

  use Application

  def start(_type, _args) do
    case RiakMorpher.Supervisor.start_link do
      {:ok, pid} ->
        :ok = :riak_core.register(vnode_module: RiakMorpher.VNode)
        :ok = :riak_core_node_watcher.service_up(RiakMorpher.Service, self())
        {:ok, pid}
      {:error, reason} ->      
        Logger.error("Unable to start NoSlides supervisor because: #{inspect reason}")
    end
  end
end

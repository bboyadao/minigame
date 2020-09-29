defmodule MinigameWeb.CustomerLive do

  use MinigameWeb, :live_view
  use KafkaEx.GenConsumer
  require Logger
  @topic_name "test_topic"


  def mount(_params, _session, socket) do
    
    a = MinigameWeb.Endpoint.subscribe(@topic_name)
    IO.inspect(a)
    # IO.inspect({__MODULE__, connected: connected?(socket), root_pid: socket.root_pid, self: self()})
    # stream = KafkaEx.stream("foobar", 0)
    # stream |> Stream.map(fn(msg) -> IO.puts(msg.value) end)
    # socket = assign(socket, query: "", context: %{})
    # {:ok, socket}
    {:ok, assign(socket, messages: [], query: "")}
    
  end

  # def handle_info(:update, socket, context) do
  #   # a = context.stream |> Stream.map(fn(msg) -> IO.puts(msg.value) end) |> Enum.to_list
  #   # IO.inspect(a)
  #   {:noreply, assign(socket, stream: a)}
  # end
  def broadcast(topic, event, msg) do

  end
  def handle_info(%{event: "new_message", payload: messages}, socket) do
    IO.inspect(messages)
    # you want to replace or append the result ? 
    # take a look at https://hexdocs.pm/phoenix_live_view/dom-patching.html
    {:noreply, assign(socket, messages)}
  end

  def render(assigns) do
    # IO.inspect(assigns)
    # a = assigns.context.def
    
    
    c = 1..3

    ~L"""
    <span class="weather">

        </span>
    <%= for user <- c do %>
    <pre>
    <%= user %>
    </pre>
    <% end %>

    """
    # stream = KafkaEx.stream("foobar", 0)
    # Enum.take(stream, 2)
    
  end

  defp have_stream(stream) do
    stream |> Enum.to_list
  end
end

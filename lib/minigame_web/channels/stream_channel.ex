defmodule MinigameWeb.StreamChannel do
  use MinigameWeb, :channel

  @impl true
  # def join("room:" <> fanpage, payload, socket) do
  def join("room:" <> fanpage, payload, socket) do
    # if authorized?(payload) do
    #   {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # stream = KafkaEx.stream(fanpage, 0)
    # Enum.take(stream, 2)
    # stream |> Stream.map(fn(msg) -> IO.puts(msg.value) end) |> Enum.to_list

    {:ok, socket}

  end



  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (stream:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end

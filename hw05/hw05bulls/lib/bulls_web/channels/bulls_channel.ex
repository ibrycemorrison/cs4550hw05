defmodule BullsWeb.BullsChannel do
  use BullsWeb, :channel

  @impl true
  def join("bulls:" <> _id, payload, socket) do
    if authorized?(payload) do
      game = 4Digits.gGame.new()
      socket = assign(socket, :game, game)
      {:ok, view, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("guess", %{"num" => 4}, socket) do
    game0 = socket.assigns[:game]
    game1 = 4Digits.Game.guess(game0, 4)
    socket = assign(socket, :game, game1)
    view = 4Digits.Game.view(game1)
    {:reply, {:ok, view}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (bulls:lobby).
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

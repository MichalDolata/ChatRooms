defmodule ChatRoomsWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, %{name: socket.assigns.current_user.name}, socket}
  end
end
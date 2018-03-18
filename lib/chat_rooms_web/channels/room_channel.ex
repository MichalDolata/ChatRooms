defmodule ChatRoomsWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    user = %{name: socket.assigns.current_user.name,
      id: socket.assigns.current_user.id}
    rooms = [
      %{
        id: 3213,
        name: "test",
        users: 123
      },
      %{
        id: 3123,
        name: "test2",
        users: 321
      }
    ]
    {:ok, %{currentUser: user, rooms: rooms}, socket}
  end

  def join("room:" <> id, _mesage, socket) do
    messages = [
      %{user: %{id: 123, name: "xd"}, message: "First message", time: DateTime.utc_now()},
      %{user: %{id: 123, name: "xd"}, message: "First message", time: DateTime.utc_now()},
      %{user: %{id: 1, name: "Michał Dolata"}, message: "First message", time: DateTime.utc_now()},
      %{user: %{id: 123, name: "xd"}, message: "First message", time: DateTime.utc_now()},
      %{user: %{id: 123, name: "xd"}, message: "First message", time: DateTime.utc_now()},
    ]
    {:ok, %{messages: messages}, socket}
  end

  def handle_in("new_message", %{"message" => message}, socket) do
    message = %{
      user: %{
        name: socket.assigns.current_user.name,
        id: socket.assigns.current_user.id
      },
      time: DateTime.utc_now(),
      message: message
    }
    broadcast! socket, "new_message", message
    {:noreply, socket}
  end

  def handle_in("new_room", %{"name" => name}, socket) do
    room = %{
      id: 1337,
      name: name,
      users: 1
    }
    {:reply, {:ok, room}, socket}
  end
end
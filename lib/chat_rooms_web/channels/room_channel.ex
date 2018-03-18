defmodule ChatRoomsWeb.RoomChannel do
  use Phoenix.Channel

  alias ChatRoomsWeb.RoomChannel

  def join("room:lobby", _message, socket) do
    user = %{name: socket.assigns.current_user.name,
      id: socket.assigns.current_user.id}

    rooms = RoomChannel.Monitor.get_rooms()
    
    {:ok, %{currentUser: user, rooms: rooms}, socket}
  end

  def join("room:" <> id, _mesage, socket) do
    messages = id
      |> String.to_integer()
      |> RoomChannel.Monitor.get_room()
      |> Map.fetch!(:messages)

    {:ok, %{messages: messages}, socket}
  end

  def handle_in("new_message", %{"message" => message}, %{topic: "room:" <> room_id} = socket) do
    if String.trim(message) !== "" do
      room_id = room_id |> String.to_integer()

      message = %{
        user: %{
          name: socket.assigns.current_user.name,
          id: socket.assigns.current_user.id
        },
        time: DateTime.utc_now(),
        message: message
      }

      RoomChannel.Monitor.add_message(room_id, message)

      broadcast! socket, "new_message", message
    end
    
    {:noreply, socket}
  end

  def handle_in("new_room", %{"name" => name}, socket) do
    room = RoomChannel.Monitor.create_room(name)

    ChatRoomsWeb.Endpoint.broadcast_from! self(), "room:lobby", "new_room", 
      room 
    {:reply, {:ok, room}, socket}
  end

  # TODO: users count update, clear empty rooms
end
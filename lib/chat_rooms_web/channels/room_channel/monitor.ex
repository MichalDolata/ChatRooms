defmodule ChatRoomsWeb.RoomChannel.Monitor do
  use Agent

  def start_link(init_state) do
    Agent.start_link(fn -> init_state end, name: __MODULE__)
  end

  def get_rooms() do
    rooms = Agent.get(__MODULE__, &(Map.fetch!(&1, :rooms)))

    rooms
    |> Enum.map(fn {_key, room} ->
      %{
        name: room.name,
        id: room.id,
      }
    end)
  end

  def create_room(name) do
    # check if exists
    name = name |> String.trim()

    new_room = %{
      id: 0, 
      name: name, 
      messages: []
    }

    # TODO: check if empty

    Agent.get_and_update(__MODULE__, fn state ->
      index = state
      |> Map.fetch!(:rooms)
      |> Enum.find_index(fn {_k, room} ->
        room.name == name
      end)

      case index do
        nil ->
          id = state[:last_id] + 1
          new_room = %{new_room | id: id}
    
          state = state
          |> Map.put(:last_id, id)
          |> put_in([:rooms, id], new_room)
          
          {new_room, state}
        _ ->
          {:error, state}
        end
    end)
  end

  def get_room(room_id) do
    Agent.get(__MODULE__, &(get_in(&1, [:rooms, room_id])))
  end

  def add_message(room_id, message) do
    Agent.update(__MODULE__, fn state ->
      update_in(state, [:rooms, room_id, :messages], &[message | &1])
    end)
  end
end
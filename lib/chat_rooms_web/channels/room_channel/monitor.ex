defmodule ChatRoomsWeb.RoomChannel.Monitor do
  use Agent

  def start_link(init_state) do
    Agent.start_link(fn -> init_state end, name: __MODULE__)
  end
end
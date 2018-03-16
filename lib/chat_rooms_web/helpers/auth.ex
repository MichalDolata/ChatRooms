defmodule ChatRoomsWeb.Helpers.Auth do
  def is_logged_in?(conn) do
    !is_nil(conn.assigns.current_user)
  end
end
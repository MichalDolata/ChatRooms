defmodule ChatRoomsWeb.RequireGuest do
  import ChatRoomsWeb.Router.Helpers
  import Phoenix.Controller

  alias ChatRooms.Accounts.User

  def init(options) do
    options
  end

  def call(conn, _options) do
    current_user = conn.assigns.current_user
    case current_user do
      %User{} -> conn |> redirect(to: page_path(conn, :chat))
      _       -> conn
    end
  end
end

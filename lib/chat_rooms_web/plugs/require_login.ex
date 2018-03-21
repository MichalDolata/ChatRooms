defmodule ChatRoomsWeb.RequireLogin do
  import ChatRoomsWeb.Router.Helpers
  import Phoenix.Controller

  alias ChatRooms.Accounts.User

  def init(options) do
    options
  end

  def call(conn, _options) do
    current_user = conn.assigns.current_user
    case current_user do
      %User{} -> conn
      _       -> conn
                |> put_flash(:error, "You have to login")
                |> redirect(to: page_path(conn, :index))
    end
  end
end

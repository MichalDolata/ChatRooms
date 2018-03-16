defmodule ChatRoomsWeb.PageController do
  use ChatRoomsWeb, :controller
  alias ChatRoomsWeb.Helpers.Auth

  plug ChatRoomsWeb.RequireLogin when action in [:chat]
  plug ChatRoomsWeb.RequireGuest when action in [:login, :register]

  def index(conn, _params) do
    case Auth.is_logged_in?(conn) do
      true ->
        redirect(conn, to: page_path(conn, :chat))
      false ->
        redirect(conn, to: page_path(conn, :login))
    end
  end

  def chat(conn, _params) do
    render conn, "chat.html"
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def register(conn, _params) do
    render conn, "register.html"
  end
end

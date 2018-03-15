defmodule ChatRoomsWeb.PageController do
  use ChatRoomsWeb, :controller

  def index(conn, _params) do
    case true do
      true ->
        redirect(conn, to: page_path(conn, :chat))
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

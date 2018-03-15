defmodule ChatRoomsWeb.Router do
  use ChatRoomsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatRoomsWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/chat", PageController, :chat
    get "/login", PageController, :login
    get "/register", PageController, :register
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatRoomsWeb do
  #   pipe_through :api
  # end
end

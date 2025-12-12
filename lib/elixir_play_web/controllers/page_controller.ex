defmodule ElixirPlayWeb.PageController do
  use ElixirPlayWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

defmodule TempleHeexInteropWeb.PageController do
  use TempleHeexInteropWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

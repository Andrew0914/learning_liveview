defmodule PocFukuroWeb.PageLive do
  use PocFukuroWeb, :live_view

  def mount(_params, _session, socket) do

    {:ok,
     assign(socket, query: "", results: %{}, client: %{id: "123abc"}, service: %{id: "456def"})}
  end
end

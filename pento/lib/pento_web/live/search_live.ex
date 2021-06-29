defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view
  alias Pento.Search
  alias Pento.Search.Searching

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign_search() |> assign_changeset()}
  end

  def assign_search(socket) do
    socket
    |> assign(:search, %Searching{})
  end

  def assign_changeset(%{assigns: %{search: search}} = socket) do
    socket
    |> assign(:changeset, Search.change_search(search))
  end

  @impl true
  def handle_event(
        "validate",
        %{"searching" => search_params},
        %{assigns: %{search: search}} = socket
      ) do
    changeset =
      search
      |> Search.change_search(search_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("search", %{"searching" => search_params}, socket) do
    :timer.sleep(5000)

    socket.assigns.search
    |> Search.do_search(search_params)

    {:noreply, socket}
  end

  @impl true
  def handle_event(
        event,
        params,
        socket
      ) do
    IO.inspect(event)
    IO.inspect(params)
    IO.inspect(socket)
  end
end

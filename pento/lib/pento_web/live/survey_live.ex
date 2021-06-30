defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias Pento.{Catalog, Accounts, Survey}

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    IO.puts("mount 1️⃣")

    {:ok,
     socket
     |> assign_user(token)
     |> assign_title("Survey")
     |> assign_list_items(["Demographic survey", "Rating products"])
     |> assign_demographic()
     |> assign_products()}
  end

  def assign_user(socket, token) do
    assign_new(socket, :current_user, fn ->
      Accounts.get_user_by_session_token(token)
    end)
  end

  def assign_title(socket, title) do
    socket |> assign(title: title)
  end

  def assign_list_items(socket, list_items) do
    socket |> assign(list_items: list_items)
  end

  def assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    IO.inspect(Survey.get_demographic_by_user(current_user))
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  def assign_products(%{assigns: %{current_user: current_user}} = socket) do
    socket |> assign(products: Catalog.list_products_with_user_ratings(current_user))
  end

  def handle_info({:created_demographic, demographic}, socket) do
    IO.puts("handle_info *️⃣")
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end
end

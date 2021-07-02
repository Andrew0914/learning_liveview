defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias Pento.{Catalog, Accounts, Survey}
  alias PentoWeb.Endpoint
  @survey_results_topic "survey_results"

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    {:ok,
     socket
     |> assign_user(token)
     |> assign_title("Survey")
     |> assign_list_items(["Demographic survey", "Rating products"])
     |> assign_demographic()
     |> assign_products()
     |> assign_show_ratings()}
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

  def assign_show_ratings(socket) do
    socket |> assign(show_ratings: true)
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

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_rating_created(
        %{assigns: %{products: products}} = socket,
        updated_product,
        product_index
      ) do
    # I'm new!
    Endpoint.broadcast(@survey_results_topic, "rating_created", %{})

    socket
    |> put_flash(:info, "Rating submitted successfully")
    |> assign(
      :products,
      List.replace_at(products, product_index, updated_product)
    )
  end

  def handle_event("toggle-ratings", _params, socket) do
    {:noreply, socket |> assign(show_ratings: !socket.assigns.show_ratings)}
  end
end

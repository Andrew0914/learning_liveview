defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view
  alias Pento.{Catalog, Accounts, Survey}

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    {:ok,
     socket
     |> assign_user(token)
     |> assign_title("Survey")
     |> assign_list_items(["Demographic survey", "Rating products"])}
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
end

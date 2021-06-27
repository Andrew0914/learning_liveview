defmodule PentoWeb.QuestionsLive.Index do
  use PentoWeb, :live_view

  alias Pento.FAQ
  alias Pento.FAQ.Questions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :questions_collection, list_questions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Questions")
    |> assign(:questions, FAQ.get_questions!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Questions")
    |> assign(:questions, %Questions{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questions")
    |> assign(:questions, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    questions = FAQ.get_questions!(id)
    {:ok, _} = FAQ.delete_questions(questions)

    {:noreply, assign(socket, :questions_collection, list_questions())}
  end

  defp list_questions do
    FAQ.list_questions()
  end
end

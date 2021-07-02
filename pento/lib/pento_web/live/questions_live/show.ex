defmodule PentoWeb.QuestionsLive.Show do
  use PentoWeb, :live_view

  alias Pento.FAQ

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def update(_assigns, socket) do
    IO.puts("update 🎄")
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:questions, FAQ.get_questions!(id))}
  end

  defp page_title(:show), do: "Show Questions"
  defp page_title(:edit), do: "Edit Questions"

  @impl true
  def handle_event("vote", _params, socket) do
    attrs = %{votes: socket.assigns.questions.votes + 1}
    questions = FAQ.vote(socket.assigns.questions, attrs)

    {:noreply,
     socket
     |> assign(questions: questions)
     |> put_flash(:info, "Questions voted successfully")}
  end
end

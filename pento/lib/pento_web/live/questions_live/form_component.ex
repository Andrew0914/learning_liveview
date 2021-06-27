defmodule PentoWeb.QuestionsLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.FAQ

  @impl true
  def update(%{questions: questions} = assigns, socket) do
    changeset = FAQ.change_questions(questions)

    new_socket =
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)

    {:ok, new_socket}
  end

  @impl true
  def handle_event("validate", %{"questions" => questions_params}, socket) do
    changeset =
      socket.assigns.questions
      |> FAQ.change_questions(questions_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"questions" => questions_params}, socket) do
    save_questions(socket, socket.assigns.action, questions_params)
  end

  defp save_questions(socket, :edit, questions_params) do
    case FAQ.update_questions(socket.assigns.questions, questions_params) do
      {:ok, _questions} ->
        {:noreply,
         socket
         |> put_flash(:info, "Questions updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_questions(socket, :new, questions_params) do
    case FAQ.create_questions(questions_params) do
      {:ok, _questions} ->
        {:noreply,
         socket
         |> put_flash(:info, "Questions created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("vote", params, socket) do
    attrs = %{votes: socket.assigns.questions.votes + 1}
    voted_question = FAQ.vote(socket.assigns.questions, attrs)

    {:noreply,
     socket
     |> put_flash(:info, "Questions voted successfully")
     |> push_redirect(to: socket.assigns.return_to)}
  end
end

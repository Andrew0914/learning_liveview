defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        time: time()
      )
    }
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  def handle_event("updateTime", %{}, socket) do
    {
      :noreply,
      assign(
        socket,
        time: time()
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    <h2>
      It's <%= @time %>
    </h2>
    <button phx-click="updateTime">Update time </Button>
    """
  end
end

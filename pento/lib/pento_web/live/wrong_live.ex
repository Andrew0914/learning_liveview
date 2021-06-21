defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        time: time(),
        win_number: Enum.random(1..10),
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    # value comes as binary "string"
    {number, _} = Integer.parse(guess)

    message =
      if socket.assigns.win_number == number,
        do: "You win 🏆, play again",
        else: "Your guess: #{guess}. Wrong ❌. Guess again. "

    score =
      if socket.assigns.win_number == number,
        do: socket.assigns.score + 1,
        else: socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        win_number: Enum.random(1..10)
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
    <pre>
      <%= @user.username %>
      <%= @session_id %>
    </pre>
    """
  end
end

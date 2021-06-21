defmodule ClientComponent do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_component
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, message: "Hello")}
  end

  def handle_event("sendMessage", %{}, socket) do
    send_update(ServiceComponent,
      id: "service1",
      message: "New message from Client: #{Enum.random(1..1000)}"
    )

    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="alert alert-info" id="<%= @id %>">
      <table>
        <tr><td> CLIENT </td> </tr>
        <tr><td>PID: </td> <td> <%= inspect(self()) %> </td> </tr>
        <tr><td>Incomming message: </td> <td> <%= @message %> </td> </tr>
      </table>
      <br>
      <button phx-click="sendMessage" type="button" phx-target="<%= @myself %>">Send message from Client</button>
    </div>
    """
  end
end

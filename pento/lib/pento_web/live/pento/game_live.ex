defmodule PentoWeb.Pento.GameLive do
  use Surface.LiveView
  alias PentoWeb.Pento.Title

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~F"""
    <section class="container">
      <Title message="Welcome to Pento! ✨" />
    </section>
    """
  end
end

defmodule PentoWeb.Pento.GameLive do
  use Surface.LiveView
  alias PentoWeb.Pento.{Title, Canvas, Palette}

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~F"""
    <section class="container">
      <Title message="Welcome to Pento!" />
      <Canvas viewBox="0 0 200 70">
        <Palette 
          shape_names={ [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t] } />
      </Canvas>
    </section>
    """
  end
end

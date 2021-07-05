defmodule PentoWeb.Pento.GameLive do
  use Surface.LiveView
  alias PentoWeb.Pento.{Canvas, Point, Title}

  def mount(_params, _session, socket), do: {:ok, socket}

  def render(assigns) do
    ~F"""
    <section class="container">
      <Title message="Welcome to Pento!" />
      <Canvas viewBox="0 0 200 30">
        <Point x={0} y={0} fill="blue" name="a" />
        <Point x={1} y={0} fill="green" name="b" />
        <Point x={0} y={1} fill="red" name="c" />
        <Point x={1} y={1} fill="black" name="d" />
      </Canvas>
    </section>
    """
  end
end

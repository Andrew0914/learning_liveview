defmodule PentoWeb.Pento.Palette do
  use Surface.Component
  alias PentoWeb.Pento.{Shape, Canvas}
  alias Pento.Game.Pentomino
  import Pento.Game.Colors
  prop shape_names, :list

  def update(%{shape_names: shape_names}, socket) do
    shapes =
      shape_names
      |> Enum.with_index()
      |> Enum.map(&pentomino/1)

    {:ok, assign(socket, shapes: shapes)}
  end

  defp pentomino({name, i}) do
    {x, y} = {rem(i, 6) * 4 + 3, div(i, 6) * 5 + 3}

    Pentomino.new(name: name, location: {x, y})
    |> Pentomino.to_shape()
  end

  def render(assigns) do
    ~F"""
    <Canvas viewBox="0 0 500 125">
      <Shape :for= { shape <- @shapes}
        points={ shape.points }
        fill={ color(shape.color) }
        name={ shape.name } />
        </Canvas>
    """
  end
end

defmodule Pento.Game.Pentomino do
  @names [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t]
  @default_location {8, 8}

  defstruct name: :i,
            rotation: 0,
            reflected: false,
            location: @default_location

  alias Pento.Game.Shape
  alias Pento.Game.Point

  def new(fields \\ []), do: __struct__(fields)

  def rotate(%{rotation: degrees} = pentomino) do
    %{pentomino | rotation: rem(degrees + 90, 360)}
  end

  def flip(%{reflected: reflection} = pentomino) do
    %{pentomino | reflected: not reflection}
  end

  def up(pentomino) do
    %{pentomino | location: Point.move(pentomino.location, {0, -1})}
  end

  def down(pentomino) do
    %{pentomino | location: Point.move(pentomino.location, {0, 1})}
  end

  def left(pentomino) do
    %{pentomino | location: Point.move(pentomino.location, {-1, 0})}
  end

  def right(pentomino) do
    %{pentomino | location: Point.move(pentomino.location, {1, 0})}
  end

  def to_shape(pentomino) do
    Shape.new(pentomino.name, pentomino.rotation, pentomino.reflected, pentomino.location)
  end
end

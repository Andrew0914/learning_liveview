defmodule Pento.Game.PentominoTest do
  use ExUnit.Case, async: true
  alias Pento.Game.Pentomino

  test "Create a new pentomino" do
    pentomino = Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 270)

    assert pentomino = %Pentomino{
             location: {11, 5},
             name: :p,
             reflected: true,
             rotation: 270
           }
  end

  test "Rotate the pentomino shape" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.rotate()

    assert pentomino = %Pentomino{
             location: {11, 5},
             name: :p,
             reflected: true,
             rotation: 180
           }
  end

  test "Rotate the pentomino shape counter clockwise" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.rotate(:conuter_clockwise)

    assert pentomino = %Pentomino{
             location: {11, 5},
             name: :p,
             reflected: true,
             rotation: 270
           }
  end

  test "Flip the pentomino shape" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.flip()

    assert pentomino = %Pentomino{
             location: {11, 5},
             name: :p,
             reflected: false,
             rotation: 180
           }
  end

  test "Move to up the pentomino shape" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.up()

    assert pentomino = %Pentomino{
             location: {11, 4},
             name: :p,
             reflected: false,
             rotation: 180
           }
  end

  test "Move to down the pentomino shape" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.down()

    assert pentomino = %Pentomino{
             location: {11, 6},
             name: :p,
             reflected: false,
             rotation: 180
           }
  end

  test "Move to left the pentomino shape" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.left()

    assert pentomino = %Pentomino{
             location: {10, 5},
             name: :p,
             reflected: false,
             rotation: 180
           }
  end

  test "Move to right the pentomino shape" do
    pentomino =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.right()

    assert pentomino = %Pentomino{
             location: {12, 5},
             name: :p,
             reflected: false,
             rotation: 180
           }
  end

  test "Convert pentomino to shape" do
    shape =
      Pentomino.new(location: {11, 5}, name: :p, reflected: true, rotation: 90)
      |> Pentomino.to_shape()

    assert shape = %Pento.Game.Shape{
             color: :orange,
             name: :p,
             points: [{12, 5}, {11, 4}, {11, 5}, {12, 4}, {10, 5}]
           }
  end
end

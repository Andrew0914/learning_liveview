defmodule Pento.Game.ShapeTest do
  use ExUnit.Case, async: true
  alias Pento.Game.Shape

  test "Create a shape" do
    shape = Shape.new(:p, 90, true, {5, 5})

    assert shape = %Shape{
             color: :orange,
             points: [{6, 5}, {5, 4}, {5, 5}, {6, 4}, {4, 5}],
             name: :p
           }
  end
end

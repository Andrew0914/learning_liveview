defmodule Pento.Game.PointTest do
  use ExUnit.Case, async: true
  alias Pento.Game.Point

  test "Create new point just with integer values" do
    assert_raise(FunctionClauseError, fn -> Point.new(1.1, "2") end)
  end

  test "Create a new point" do
    point = Point.new(1, 0)
    assert point = {1, 0}
  end

  test "Move a point" do
    point = Point.new(1, 0) |> Point.move({1, 2})
    assert point = {2, 2}
  end

  test "Flip the point" do
    point = Point.new(0, 1) |> Point.flip()
    assert point = {0, 5}
  end

  test "Reflect the point" do
    point = Point.new(0, 1) |> Point.reflect()
    assert point = {6, 1}
  end

  test "Transpose the point" do
    point = Point.new(0, 1) |> Point.transpose()
    assert point = {1, 0}
  end

  test "Rotate the point 0 degrees" do
    point = Point.new(0, 1) |> Point.rotate(0)
    assert point = {0, 1}
  end

  test "Rotate the point 90 degrees" do
    point = Point.new(0, 1) |> Point.rotate(90)
    assert point = {1, 6}
  end

  test "Rotate the point 180 degrees" do
    point = Point.new(0, 1) |> Point.rotate(180)
    assert point = {6, 5}
  end

  test "Rotate the point 270 degrees" do
    point = Point.new(0, 1) |> Point.rotate(270)
    assert point = {5, 0}
  end

  test "Rotate the point to a invalid number  degrees" do
    assert_raise FunctionClauseError, fn -> Point.new(0, 1) |> Point.rotate(480) end
  end

  test "Center a point" do
    point = Point.new(1, 1)
    centered_point = point |> Point.center()

    assert centered_point = {-2, -2}
  end

  test "Prepare a point with reflection" do
    point = Point.new(0, 0)
    prepared = point |> Point.prepare(0, true, {1, 1})

    assert prepared = {7, 1}
  end

  test "Prepare a point without reflection" do
    point = Point.new(0, 0)
    prepared = point |> Point.prepare(90, false, {1, 1})

    assert prepared = {1, 7}
  end
end

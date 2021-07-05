defmodule PentoWeb.Pento.Point do
  use Surface.Component

  @width 10

  prop x, :integer
  prop y, :integer
  prop fill, :string
  prop name, :string

  defp convert(i) do
    (i - 1) * @width + 2 * @width
  end

  def render(assigns) do
    ~F"""
    <use
      xlink:href="#point"
      x={ convert(@x) }
      y={ convert(@y) }
      fill={ @fill } />
    """
  end
end

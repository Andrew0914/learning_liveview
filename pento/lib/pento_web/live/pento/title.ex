defmodule PentoWeb.Pento.Title do
  use Surface.Component
  prop(message, :string, required: true)

  def render(assigns) do
    IO.inspect assigns.message
    ~F"""
    <h1>{ @message }</h1>
    """
  end
end

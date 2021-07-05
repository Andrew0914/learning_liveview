defmodule PentoWeb.Pento.Title do
  use Surface.Component

  @doc "Someone to say hello to"
  prop message, :string, required: true

  def render(assigns) do
    ~F"""
    <h1>{ @message }</h1>
    """
  end
end

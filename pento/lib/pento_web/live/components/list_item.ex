defmodule PentoWeb.Live.Components.ListItem do
  use PentoWeb, :live_component

  def render(assigns) do
    ~L"""
    <li> <%= @content %> </li>
    """
  end
end
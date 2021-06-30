defmodule PentoWeb.Live.Components.Title do
  use PentoWeb, :live_component

  def render(assigns) do
    ~L"""
    <h1> <%= @title %> </h1>
    """
  end
end
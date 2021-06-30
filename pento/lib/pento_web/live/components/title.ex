defmodule PentoWeb.Live.Components.Title do
  use PentoWeb, :live_component

  def preload(list_of_assigns) do
    Enum.map(list_of_assigns, fn %{id: id, title: title} ->
      %{id: id, title: "#{title} #{id}", subtitle: "Subtitle #{id}"}
    end)
  end

  def render(assigns) do
    ~L"""
    <h1> <%= @title %> </h1>
    <h2> <%= @subtitle %> </h2>
    """
  end
end

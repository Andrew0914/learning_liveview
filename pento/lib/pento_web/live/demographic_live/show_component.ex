defmodule PentoWeb.DemographicLive.ShowComponent do
  use PentoWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="box">
      <h3>Demographics ✅</h3>
        <ul>
          <li>Year of birth: <%= @demographic.year_of_birth %></li>
          <li>Gender: <%= @demographic.gender %></li>
        </ul>
    </div>
    """
  end
end

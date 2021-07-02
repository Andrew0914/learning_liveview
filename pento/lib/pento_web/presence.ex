defmodule PentoWeb.Presence do
  @moduledoc """
  Provides presence tracking to channels and processes.

  See the [`Phoenix.Presence`](http://hexdocs.pm/phoenix/Phoenix.Presence.html)
  docs for more details.
  """
  use Phoenix.Presence,
    otp_app: :pento,
    pubsub_server: Pento.PubSub

  alias Pento.Accounts
  alias PentoWeb.Presence
  @user_activity_topic "user_activity"
  @survey_presence "survey_presence"

  def track_user(pid, product, token) do
    user = Accounts.get_user_by_session_token(token)

    Presence.track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: user.email}]}
    )
  end

  def list_products_and_users do
    Presence.list(@user_activity_topic)
    |> Enum.map(&extract_users/1)
  end

  defp extract_users({key, %{metas: metas}}) do
    {key, users_from_metas_list(metas)}
  end

  defp users_from_metas_list(metas_list) do
    Enum.map(metas_list, &users_from_meta_map/1)
    |> List.flatten()
    |> Enum.uniq()
  end

  def users_from_meta_map(meta_map) do
    get_in(meta_map, [:users])
  end

  def track_user_survey(pid, user_token) do
    user = Accounts.get_user_by_session_token(user_token)

    Presence.track(
      pid,
      @survey_presence,
      "survey",
      %{users: [%{email: user.email}]}
    )
  end

  def list_survey_presence do
    Presence.list(@survey_presence)
    |> Enum.map(&extract_users/1)
  end

end

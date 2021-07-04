defmodule PentoWeb.SurveyLiveTest do
  # es necesario para usar LiveViewTest
  use PentoWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "Survey live demoigraphics" do
    setup [:register_and_log_in_user]

    test "it filters by age group", %{conn: conn, user: user} do
      {:ok, view, _html} = live(conn, "/survey")

      params = %{"gender" => "male", "year_of_birth" => "1993", "user_id" => user.id}

      view
      |> element("#demographic-form-#{user.id}")
      |> render_submit(params)

      :timer.sleep(1)

      assert render(view) =~ "<h3>Demographics ✅</h3>"
    end
  end
end

defmodule PentoWeb.QuestionsLiveTest do
  use PentoWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Pento.FAQ

  @create_attrs %{answer: "some answer", question: "some question", votes: 42}
  @update_attrs %{answer: "some updated answer", question: "some updated question", votes: 43}
  @invalid_attrs %{answer: nil, question: nil, votes: nil}

  defp fixture(:questions) do
    {:ok, questions} = FAQ.create_questions(@create_attrs)
    questions
  end

  defp create_questions(_) do
    questions = fixture(:questions)
    %{questions: questions}
  end

  describe "Index" do
    setup [:create_questions]

    test "lists all questions", %{conn: conn, questions: questions} do
      {:ok, _index_live, html} = live(conn, Routes.questions_index_path(conn, :index))

      assert html =~ "Listing Questions"
      assert html =~ questions.answer
    end

    test "saves new questions", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.questions_index_path(conn, :index))

      assert index_live |> element("a", "New Questions") |> render_click() =~
               "New Questions"

      assert_patch(index_live, Routes.questions_index_path(conn, :new))

      assert index_live
             |> form("#questions-form", questions: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#questions-form", questions: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.questions_index_path(conn, :index))

      assert html =~ "Questions created successfully"
      assert html =~ "some answer"
    end

    test "updates questions in listing", %{conn: conn, questions: questions} do
      {:ok, index_live, _html} = live(conn, Routes.questions_index_path(conn, :index))

      assert index_live |> element("#questions-#{questions.id} a", "Edit") |> render_click() =~
               "Edit Questions"

      assert_patch(index_live, Routes.questions_index_path(conn, :edit, questions))

      assert index_live
             |> form("#questions-form", questions: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#questions-form", questions: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.questions_index_path(conn, :index))

      assert html =~ "Questions updated successfully"
      assert html =~ "some updated answer"
    end

    test "deletes questions in listing", %{conn: conn, questions: questions} do
      {:ok, index_live, _html} = live(conn, Routes.questions_index_path(conn, :index))

      assert index_live |> element("#questions-#{questions.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#questions-#{questions.id}")
    end
  end

  describe "Show" do
    setup [:create_questions]

    test "displays questions", %{conn: conn, questions: questions} do
      {:ok, _show_live, html} = live(conn, Routes.questions_show_path(conn, :show, questions))

      assert html =~ "Show Questions"
      assert html =~ questions.answer
    end

    test "updates questions within modal", %{conn: conn, questions: questions} do
      {:ok, show_live, _html} = live(conn, Routes.questions_show_path(conn, :show, questions))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Questions"

      assert_patch(show_live, Routes.questions_show_path(conn, :edit, questions))

      assert show_live
             |> form("#questions-form", questions: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#questions-form", questions: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.questions_show_path(conn, :show, questions))

      assert html =~ "Questions updated successfully"
      assert html =~ "some updated answer"
    end
  end
end

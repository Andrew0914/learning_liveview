defmodule Pento.FAQTest do
  use Pento.DataCase

  alias Pento.FAQ

  describe "questions" do
    alias Pento.FAQ.Questions

    @valid_attrs %{answer: "some answer", question: "some question", votes: 42}
    @update_attrs %{answer: "some updated answer", question: "some updated question", votes: 43}
    @invalid_attrs %{answer: nil, question: nil, votes: nil}

    def questions_fixture(attrs \\ %{}) do
      {:ok, questions} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FAQ.create_questions()

      questions
    end

    test "list_questions/0 returns all questions" do
      questions = questions_fixture()
      assert FAQ.list_questions() == [questions]
    end

    test "get_questions!/1 returns the questions with given id" do
      questions = questions_fixture()
      assert FAQ.get_questions!(questions.id) == questions
    end

    test "create_questions/1 with valid data creates a questions" do
      assert {:ok, %Questions{} = questions} = FAQ.create_questions(@valid_attrs)
      assert questions.answer == "some answer"
      assert questions.question == "some question"
      assert questions.votes == 42
    end

    test "create_questions/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FAQ.create_questions(@invalid_attrs)
    end

    test "update_questions/2 with valid data updates the questions" do
      questions = questions_fixture()
      assert {:ok, %Questions{} = questions} = FAQ.update_questions(questions, @update_attrs)
      assert questions.answer == "some updated answer"
      assert questions.question == "some updated question"
      assert questions.votes == 43
    end

    test "update_questions/2 with invalid data returns error changeset" do
      questions = questions_fixture()
      assert {:error, %Ecto.Changeset{}} = FAQ.update_questions(questions, @invalid_attrs)
      assert questions == FAQ.get_questions!(questions.id)
    end

    test "delete_questions/1 deletes the questions" do
      questions = questions_fixture()
      assert {:ok, %Questions{}} = FAQ.delete_questions(questions)
      assert_raise Ecto.NoResultsError, fn -> FAQ.get_questions!(questions.id) end
    end

    test "change_questions/1 returns a questions changeset" do
      questions = questions_fixture()
      assert %Ecto.Changeset{} = FAQ.change_questions(questions)
    end
  end
end

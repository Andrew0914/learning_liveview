defmodule Pento.FAQ.Questions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answer, :string
    field :question, :string
    field :votes, :integer

    timestamps()
  end

  @doc false
  def changeset(questions, attrs) do
    questions
    |> cast(attrs, [:question, :answer, :votes])
    |> validate_required([:question, :votes])
  end

  def votes_changeset(question, attrs) do
    question
    |> cast(attrs, [:votes])
  end
end

defmodule Pento.Search.Searching do
  defstruct [:search]
  @types %{search: :integer}

  alias Pento.Search.Searching
  import Ecto.Changeset

  def changeset(%Searching{} = searching, attrs) do
    {searching, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_number(:search, greater_than: 999_999)
  end
end

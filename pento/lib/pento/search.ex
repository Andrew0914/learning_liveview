defmodule Pento.Search do
  alias Pento.Search.Searching

  def change_search(%Searching{}= searching, attrs \\ %{}) do
    Searching.changeset(searching, attrs)
  end

  def do_search(searching, attrs) do
    IO.puts("Search")
    IO.inspect({searching, attrs})
  end
end
defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Catalog.Product

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    timestamps()
  end

  def validate_price(product) do
    product
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_price()
  end

  def validate_price_decrease(changeset, product) do
    if get_change(changeset, :unit_price) < product.unit_price do
      changeset
    else
      add_error(changeset, :unit_price, "price is not decreasimg")
    end
  end

  def unit_price_changeset(product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_price_decrease(product)
  end
end

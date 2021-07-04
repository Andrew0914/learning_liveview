defmodule PentoWeb.RatingLive.IndexComponentTest do
  # es necesario para usar LiveViewTest
  use PentoWeb.ConnCase
  import Phoenix.LiveViewTest
  alias PentoWeb.RatingLive.IndexComponent

  alias Pento.{Accounts, Catalog, Survey}

  @create_product_attrs %{
    description: "test description",
    name: "Test Game",
    sku: 42,
    unit_price: 120.5
  }

  @create_user_attrs %{email: "test@test.com", password: "passwordpassword", username: "test1"}

  defp user_fixture(attrs \\ @create_user_attrs) do
    {:ok, user} = Accounts.register_user(attrs)
    user
  end

  defp product_fixture do
    {:ok, product} = Catalog.create_product(@create_product_attrs)
    product
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end

  defp rating_fixture(user, product, stars) do
    {:ok, rating} =
      Survey.create_rating(%{
        stars: stars,
        user_id: user.id,
        product_id: product.id
      })

    rating
  end

  defp create_rating(user, product, stars) do
    rating = rating_fixture(user, product, stars)
    %{rating: rating}
  end

  describe "Index component" do
    setup [:create_product, :create_user]

    test "Show form for product when it has no rating", %{user: user} do
      products = Catalog.list_products_with_user_ratings(user)
      product = products |> Enum.at(0)

      html =
        render_component(IndexComponent, products: products, current_user: user, isShow: true)

      assert html =~ "product-#{product.id}-form"
    end

    test "Show raiting for product when it exists", %{user: user, product: product} do
      create_rating(user, product, 5)
      products = Catalog.list_products_with_user_ratings(user)

      html =
        render_component(IndexComponent, products: products, current_user: user, isShow: true)

      assert html =~ "<h4> Test Game:⭐ ⭐ ⭐ ⭐ ⭐ </h4>"
    end
  end
end

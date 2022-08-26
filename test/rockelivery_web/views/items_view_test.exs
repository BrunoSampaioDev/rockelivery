defmodule RockeliveryWeb.ItemsViewTest do
  use RockeliveryWeb.ConnCase, async: true
  import Phoenix.View
  import Rockelivery.Factory
  alias Rockelivery.Item
  alias RockeliveryWeb.ItemsView

  describe "item view/1" do
    test "renders create json" do
      item = build(:item)

      response = render(ItemsView, "create.json", item: item)

      assert %{
               message: "item created",
               item: %Item{
                 category: :food,
                 description: "Pizza de banana",
                 id: "84915c02-6537-4859-b609-87b2b9bf67a3",
                 inserted_at: nil,
                 photo: "http://",
                 price: "12.50"
               }
             } == response
    end

    test "renders item json" do
      item = build(:item)

      response = render(ItemsView, "item.json", item: item)

      assert %{
               item: %Item{
                 category: :food,
                 description: "Pizza de banana",
                 id: "84915c02-6537-4859-b609-87b2b9bf67a3",
                 inserted_at: nil,
                 photo: "http://",
                 price: "12.50"
               }
             } == response
    end
  end
end

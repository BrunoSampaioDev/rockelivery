defmodule RockeliveryWeb.ItemsView do
  use RockeliveryWeb, :view
  alias Rockelivery.Item

  def render("create.json", %{item: %Item{} = item}) do
    %{
      message: "item created",
      item: item
    }
  end
end

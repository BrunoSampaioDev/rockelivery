defmodule RockeliveryWeb.OrdersView do
  use RockeliveryWeb, :view
  alias Rockelivery.Order

  def render("create.json", %{order: %Order{} = order}) do
    %{
      message: "order created",
      order: order
    }
  end
end

defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view
  alias Rockelivery.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "user created",
      user: user
    }
  end
end
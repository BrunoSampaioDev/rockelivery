defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true
  import Phoenix.View
  import Rockelivery.Factory
  alias RockeliveryWeb.UsersView

  test "renders create json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "user created",
             user: %Rockelivery.User{
               address: "any_address",
               age: 31,
               cep: "00000000",
               cpf: "13718203766",
               email: "any_mail@mail.com",
               id: "84915c02-6537-4859-b609-87b2b9bf67a3",
               inserted_at: nil,
               name: "any name",
               password: "123123",
               password_hash: nil,
               updated_at: nil
             }
           } == response
  end
end

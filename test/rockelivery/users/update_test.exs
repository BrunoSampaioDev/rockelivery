defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  import Rockelivery.Factory
  alias Rockelivery.Users.Update

  describe "call/1" do
    test "when are valid id, updated the user" do
      insert(:user)

      params =
        build(:user_params, %{
          "id" => "84915c02-6537-4859-b609-87b2b9bf67a3",
          "email" => "new_mail@mail.com.br",
          "address" => "new address 00",
          "cpf" => "13718203761",
          "cep" => "00000000"
        })

      response = Update.call(params)

      assert {:ok, %User{email: "new_mail@mail.com.br", address: "new address 00"}} = response
    end

    test "when are not valid id, returns the error" do
      insert(:user)

      params =
        build(:user_params, %{
          "id" => "84915c02-6537-4859-b609-87b2b9bf67a4",
          "email" => "new_mail@mail.com.br",
          "address" => "new address 00",
          "cpf" => "13718203761"
        })

      response = Update.call(params)

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end

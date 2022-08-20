defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  import Rockelivery.Factory
  alias Rockelivery.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params, %{"age" => 32, "email" => "any_mail@mail.com"})

      response = Create.call(params)

      assert {:ok, %User{id: _id, age: 32, email: "any_mail@mail.com"}} = response
    end

    test "when there are valid params, returns an error" do
      params = build(:user_params, %{"age" => 17, "cpf" => "1234"})

      response = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        cpf: ["should be 11 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end

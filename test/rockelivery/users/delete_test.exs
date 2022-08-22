defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  import Rockelivery.Factory
  alias Rockelivery.Users.Delete
  alias Rockelivery.Users.Get

  describe "call/1" do
    test "when are valid id, delete the user" do
      id = "84915c02-6537-4859-b609-87b2b9bf67a3"
      insert(:user)

      response = Delete.call(id)
      verify_user_exists = Get.by_id(id)

      assert {:ok, %User{id: "84915c02-6537-4859-b609-87b2b9bf67a3"}} = response

      assert {:error, %Rockelivery.Error{result: "User not found", status: :not_found}} =
               verify_user_exists
    end

    test "when are not valid id, returns the error" do
      id = "84915c02-6537-4859-b609-87b2b9bf67a4"
      insert(:user)

      response = Delete.call(id)

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end

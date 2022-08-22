defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, User}
  import Rockelivery.Factory
  alias Rockelivery.Users.Get

  describe "by_id/1" do
    test "when are valid id, returns the user" do
      id = "84915c02-6537-4859-b609-87b2b9bf67a3"
      insert(:user)

      response = Get.by_id(id)

      assert {:ok, %User{id: "84915c02-6537-4859-b609-87b2b9bf67a3"}} = response
    end

    test "when are not valid id, returns the error" do
      id = "84915c02-6537-4859-b609-87b2b9bf67a4"
      insert(:user)

      response = Get.by_id(id)

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end

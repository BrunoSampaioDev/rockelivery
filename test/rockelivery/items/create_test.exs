defmodule Rockelivery.Items.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.{Error, Item}
  import Rockelivery.Factory
  alias Rockelivery.Items.Create

  describe "call/1" do
    test "when all params are valid, returns the item" do
      params = build(:item_params)

      response = Create.call(params)

      assert {:ok, %Item{category: :food, description: "Pizza de banana"}} = response
    end

    test "when a invalid category, returns the Error" do
      params = build(:item_params, %{"category" => "invalid_category"})

      expected_response = %{category: ["is invalid"]}

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when a invalid description, returns the Error" do
      params = build(:item_params, %{"description" => ""})

      expected_response = %{description: ["can't be blank"]}

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when the description is less than 6 characters, returns the Error" do
      params = build(:item_params, %{"description" => "any"})

      expected_response = %{description: ["should be at least 6 character(s)"]}

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end

    test "when the price not decimal, returns the Error" do
      params = build(:item_params, %{"price" => "sdf"})

      expected_response = %{price: ["is invalid"]}

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end

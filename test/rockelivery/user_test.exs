defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true
  alias Ecto.Changeset
  alias Rockelivery.User
  import Rockelivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params, %{cep: "00000000"})

      response = User.changeset(params)

      assert %Changeset{changes: %{cpf: "13718203766"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset the given changes" do
      params = build(:user_params, %{cep: "00000000"})

      update_params = %{name: "new_name", password: "123123"}

      reponse =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "new_name"}, valid?: true} = reponse
    end

    test "when there are some error, return an invalid changeset" do
      params = build(:user_params, %{cep: "123"})

      reponse = params |> User.changeset()

      expected_response = %{cep: ["should be 8 character(s)"]}
      assert errors_on(reponse) === expected_response
    end
  end
end

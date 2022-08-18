defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true
  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        address: Faker.Address.PtBr.street_address(),
        age: 31,
        cep: String.replace(Faker.Address.PtBr.zip_code(), ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~-]/, ""),
        cpf: "13718203766",
        email: "any_mail@mail.com",
        password: "123123",
        name: Faker.Person.PtBr.name()
      }

      response = User.changeset(params)

      assert %Changeset{changes: %{cpf: "13718203766"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset the given changes" do
      params = %{
        address: Faker.Address.PtBr.street_address(),
        age: 31,
        cep: String.replace(Faker.Address.PtBr.zip_code(), ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~-]/, ""),
        cpf: "13718203766",
        email: "any_mail@mail.com",
        password: "123123",
        name: Faker.Person.PtBr.name()
      }

      update_params = %{name: "new_name", password: "123123"}

      reponse =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "new_name"}, valid?: true} = reponse
    end

    test "when there are some error, return an invalid changeset" do
      params = %{
        address: Faker.Address.PtBr.street_address(),
        age: 31,
        cep: Faker.Address.PtBr.zip_code(),
        cpf: "13718203766",
        email: "any_mail@mail.com",
        password: "176764223",
        name: Faker.Person.PtBr.name()
      }

      reponse = params |> User.changeset()

      expected_response = %{cep: ["should be 8 character(s)"]}
      assert errors_on(reponse) === expected_response
    end
  end
end

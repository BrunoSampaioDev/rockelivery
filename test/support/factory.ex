defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo
  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => Faker.Address.PtBr.street_address(),
      "age" => 31,
      "cep" => Faker.Address.PtBr.zip_code(),
      "cpf" => "13718203766",
      "email" => "#{Faker.Person.PtBr.name()}@#{Faker.Internet.PtBr.free_email_service()}",
      "password" => "123123",
      "name" => Faker.Person.PtBr.name()
    }
  end

  def user_factory do
    %User{
      address: "any_address",
      age: 31,
      cep: "00000000",
      cpf: "13718203766",
      email: "any_mail@mail.com",
      password: "123123",
      name: "any name",
      id: "84915c02-6537-4859-b609-87b2b9bf67a3"
    }
  end
end
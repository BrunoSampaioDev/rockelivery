defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.Item
  alias Rockelivery.User

  def user_params_factory do
    %{
      "address" => Faker.Address.PtBr.street_address(),
      "age" => 31,
      "cep" => "01001000",
      "cpf" => "13718203766",
      "email" => "#{Faker.Person.PtBr.name()}@#{Faker.Internet.PtBr.free_email_service()}",
      "password" => "123123",
      "name" => Faker.Person.PtBr.name()
    }
  end

  def item_params_factory do
    %{
      "category" => "food",
      "description" => "Pizza de banana",
      "price" => "12.50",
      "photo" => "http://"
    }
  end

  def user_factory do
    %User{
      address: "any_address",
      age: 31,
      cep: "01001000",
      cpf: "13718203766",
      email: "any_mail@mail.com",
      password: "123123",
      name: "any name",
      id: "84915c02-6537-4859-b609-87b2b9bf67a3"
    }
  end

  def item_factory do
    %Item{
      category: :food,
      description: "Pizza de banana",
      id: "84915c02-6537-4859-b609-87b2b9bf67a3",
      inserted_at: nil,
      photo: "http://",
      price: "12.50",
      updated_at: nil
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end

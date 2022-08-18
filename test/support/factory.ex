defmodule Rockelivery.Factory do
  use ExMachina

  def user_params_factory() do
    %{
      address: Faker.Address.PtBr.street_address(),
      age: 31,
      cep: Faker.Address.PtBr.zip_code(),
      cpf: "13718203766",
      email: "#{Faker.Person.PtBr.name()}@#{Faker.Internet.PtBr.free_email_service()}",
      password: "123123",
      name: Faker.Person.PtBr.name()
    }
  end
end

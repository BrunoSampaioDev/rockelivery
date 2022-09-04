defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.UsersHelpers
  alias Rockelivery.ViaCep.Client

  def call(%{"cep" => cep} = params) do
    changeset =
      params
      |> UsersHelpers.normalize_cep()
      |> UsersHelpers.normalize_cpf()
      |> User.changeset()

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, _cep_info} <- Client.get_cep_info(cep),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end
end

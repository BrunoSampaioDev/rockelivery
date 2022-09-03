defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.ViaCep.Client

  def call(%{"cep" => cep} = params) do
    case Client.get_cep_info(cep) do
      {:ok, _cep_info} -> create_user(params)
      {:error, result} = error -> error
    end
  end

  defp create_user(params) do
    params
    |> normalize_cep()
    |> normalize_cpf()
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp normalize_cpf(%{"cpf" => cpf} = params) do
    normal = String.replace(cpf, ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~-]/, "")
    %{params | "cpf" => normal}
  end

  defp normalize_cep(%{"cep" => cep} = params) do
    normal = String.replace(cep, ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~-]/, "")
    %{params | "cep" => normal}
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end

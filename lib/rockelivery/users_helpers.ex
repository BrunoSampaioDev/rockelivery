defmodule Rockelivery.UsersHelpers do
  def normalize_cpf(%{"cpf" => cpf} = params) do
    normal = String.replace(cpf, ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~-]/, "")
    %{params | "cpf" => normal}
  end

  def normalize_cep(%{"cep" => cep} = params) do
    normal = String.replace(cep, ~r/[!#$%&()*+,.:;<=>?@\^_`{|}~-]/, "")
    %{params | "cep" => normal}
  end
end

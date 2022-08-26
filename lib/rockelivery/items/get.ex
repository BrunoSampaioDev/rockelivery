defmodule Rockelivery.Items.Get do
  alias Rockelivery.{Error, Item, Repo}

  def by_id(id) do
    case Repo.get(Item, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      item -> {:ok, item}
    end
  end
end

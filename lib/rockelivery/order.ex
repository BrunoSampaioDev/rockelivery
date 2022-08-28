defmodule Rockelivery.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rockelivery.{Item, User}
  @primary_key {:id, :binary_id, autogenerate: true}
  @payment_method [:money, :credit_card, :debit_card]
  @required_params [:adress, :comments, :payment_method, :user_id]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "orders" do
    field :adress, :string
    field :comments, :string
    field :payment_method, Ecto.Enum, values: @payment_method
    field :user_id, :string

    many_to_many :items, Item, join_through: "orders_items"
    belongs_to :users, User

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> put_assoc(:items, items)
  end
end

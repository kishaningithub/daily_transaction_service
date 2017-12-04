defmodule DailyTransactionService.DailyTransaction do
  use DailyTransactionService.Web, :model

  schema "daily_transactions" do
    field :transaction_date, :utc_datetime
    field :amount, :decimal
    field :type_of_transaction, :string
    field :description, :string
    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:transaction_date, :amount, :type_of_transaction, :description])
    |> validate_required([:transaction_date, :amount, :type_of_transaction, :description])
    |> validate_inclusion(:type_of_transaction, ["D", "C"], message: "Should be either D or C i.e Debit or Credit")
  end
end

defmodule DailyTransactionService.DailyTransactionTest do
  use DailyTransactionService.ModelCase

  alias DailyTransactionService.DailyTransaction

  @valid_attrs %{
    transaction_date: DateTime.utc_now,
    amount: 350,
    type_of_transaction: "D",
    description: "OLA Cab"
  }

  @invalid_attrs %{
    transaction_date: DateTime.utc_now,
    amount: 350,
    type_of_transaction: "Invalid Type Of Transaction",
    description: "OLA Cab"
  }

  test "changeset with valid attributes" do
    changeset = DailyTransaction.changeset(%DailyTransaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DailyTransaction.changeset(%DailyTransaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end

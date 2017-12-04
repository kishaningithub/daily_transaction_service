defmodule DailyTransactionService.DailyTransactionView do
  use DailyTransactionService.Web, :view

  def render("index.json", %{ daily_transactions: daily_transactions }) do
    render_many(daily_transactions, DailyTransactionService.DailyTransactionView, "daily_transaction.json")
  end

  def render("show.json", %{daily_transaction: daily_transaction}) do
    render_one(daily_transaction, DailyTransactionService.DailyTransactionView, "daily_transaction.json")
  end

  def render("daily_transaction.json", %{daily_transaction: daily_transaction}) do
    %{
      id: daily_transaction.id,
      transaction_date: daily_transaction.transaction_date,
      amount: daily_transaction.amount,
      type_of_transaction: daily_transaction.type_of_transaction,
      description: daily_transaction.description
    }
  end
end

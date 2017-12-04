defmodule DailyTransactionService.Repo.Migrations.CreateDailyTransaction do
  use Ecto.Migration

  def change do
    create table(:daily_transactions) do
      add :transaction_date , :timestamptz
      add :amount, :numeric
      add :type_of_transaction, :text
      add :description, :text
      timestamps(type: :timestamptz)
    end

  end
end

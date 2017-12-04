defmodule DailyTransactionService.DailyTransactionController do
  use DailyTransactionService.Web, :controller

  alias DailyTransactionService.DailyTransaction

  import Ecto.Query, only: [from: 2]
  
  def index(conn, _params) do
    query =   
      from DailyTransaction, order_by: [desc: :transaction_date]
          
    daily_transactions = Repo.all(query)
    render(conn, "index.json", %{daily_transactions: daily_transactions })
  end

  def create(conn, daily_transaction_params) do
    changeset = DailyTransaction.changeset(%DailyTransaction{}, daily_transaction_params)

    case Repo.insert(changeset) do
      {:ok, daily_transaction} ->
        conn  
        |> put_status(:created)
        |> put_resp_header("location", daily_transaction_path(conn, :show, daily_transaction))
        |> render("show.json", %{daily_transaction: daily_transaction})
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DailyTransactionService.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    daily_transaction = Repo.get!(DailyTransaction, id)
    render(conn, "show.json", %{daily_transaction: daily_transaction})
  end

  def update(conn, %{"id" => id, "daily_transaction" => daily_transaction_params}) do
    daily_transaction = Repo.get!(DailyTransaction, id)
    changeset = DailyTransaction.changeset(daily_transaction, daily_transaction_params)

    case Repo.update(changeset) do
      {:ok, daily_transaction} ->
        render(conn, "show.json", daily_transaction: daily_transaction)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(DailyTransactionService.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    daily_transaction = Repo.get!(DailyTransaction, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(daily_transaction)

    send_resp(conn, :no_content, "")
  end
end

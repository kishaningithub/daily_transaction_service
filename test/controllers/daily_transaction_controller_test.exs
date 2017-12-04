defmodule DailyTransactionService.DailyTransactionControllerTest do
  use DailyTransactionService.ConnCase

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

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, daily_transaction_path(conn, :index)
    assert json_response(conn, 200) == []
  end

  test "shows chosen resource", %{conn: conn} do
    transaction_date = DateTime.utc_now
    daily_transaction = Repo.insert! %DailyTransaction{
      transaction_date: transaction_date,
      amount: 350,
      type_of_transaction: "D",
      description: "OLA Cab"
    }
    conn = get conn, daily_transaction_path(conn, :show, daily_transaction)
    assert json_response(conn, 200) == %{
      "id" => daily_transaction.id,
      "transaction_date" => DateTime.to_iso8601(transaction_date),
      "amount" => "350",
      "type_of_transaction" => "D",
      "description" => "OLA Cab"
    }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, daily_transaction_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, daily_transaction_path(conn, :create), @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(DailyTransaction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, daily_transaction_path(conn, :create), @invalid_attrs
    assert json_response(conn, 422)["errors"] == %{"type_of_transaction" => ["Should be either D or C i.e Debit or Credit"]}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    daily_transaction = Repo.insert! %DailyTransaction{}
    conn = put conn, daily_transaction_path(conn, :update, daily_transaction), daily_transaction: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(DailyTransaction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    daily_transaction = Repo.insert! %DailyTransaction{}
    conn = put conn, daily_transaction_path(conn, :update, daily_transaction), daily_transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    daily_transaction = Repo.insert! %DailyTransaction{}
    conn = delete conn, daily_transaction_path(conn, :delete, daily_transaction)
    assert response(conn, 204)
    refute Repo.get(DailyTransaction, daily_transaction.id)
  end
end

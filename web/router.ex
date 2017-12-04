defmodule DailyTransactionService.Router do
  use DailyTransactionService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DailyTransactionService do
    pipe_through :api

    resources "/daily_transactions", DailyTransactionController, except: [:new, :edit]
  end
end

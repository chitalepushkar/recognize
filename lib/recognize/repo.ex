defmodule Recognize.Repo do
  use Ecto.Repo,
    otp_app: :recognize,
    adapter: Ecto.Adapters.Postgres
end

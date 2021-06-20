defmodule PocFukuro.Repo do
  use Ecto.Repo,
    otp_app: :poc_fukuro,
    adapter: Ecto.Adapters.Postgres
end

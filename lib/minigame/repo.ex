defmodule Minigame.Repo do
  use Ecto.Repo,
    otp_app: :minigame,
    adapter: Ecto.Adapters.Postgres
end

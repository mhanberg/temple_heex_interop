defmodule TempleHeexInterop.Repo do
  use Ecto.Repo,
    otp_app: :temple_heex_interop,
    adapter: Ecto.Adapters.Postgres
end

defmodule DeezerWrapper.Repo do
  use Ecto.Repo,
    otp_app: :deezer_wrapper,
    adapter: Ecto.Adapters.Postgres
end

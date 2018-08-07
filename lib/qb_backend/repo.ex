defmodule QbBackend.Repo do
  use Ecto.Repo, otp_app: :qb_backend

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, opts}
  end
end

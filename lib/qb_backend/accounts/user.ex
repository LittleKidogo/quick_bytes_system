defmodule QbBackend.Accounts.User do
  @moduledoc """
  This Module contains changeset functions used to create and
  Manipulate user records in the database
  """
  use Ecto.Schema

  import Ecto.Changeset
  alias Comeonin.Bcrypt

  alias QbBackend.Accounts.User

  @type t :: %__MODULE__{}

  # set up binary key
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field(:name, :string)
    field(:hash, :string)

    timestamps(inserted_at: :joined_on, updated_at: :updated_at)
  end

  @doc """
  This function accepts a map of parameters and uses them to prepare
  a user record for the database
  """
  @spec changeset(User.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def changeset(%User{} = usr, attrs) do
    usr
    |> cast(attrs, [:name, :hash])
    |> validate_required([:name, :hash])
    |> hash_password()
  end

  @spec hash_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp hash_password(%{valid?: true, changes: %{hash: hash}} = changeset) do
    change(changeset, hash: Bcrypt.hashpwsalt(hash))
  end

  defp hash_password(changeset), do: changeset
end

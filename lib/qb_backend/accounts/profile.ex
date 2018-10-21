defmodule QbBackend.Accounts.Profile do
  @moduledoc """
  This Module contains changeset functions used to create and
  Manipulate user profiles in the database
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias QbBackend.{
    Accounts.User,
    Accounts.Profile,
    Posts.Bookmark
  }

  @type t :: %__MODULE__{}

  # set up binary key
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "profiles" do
    field(:username, :string)
    field(:bio, :string)
    # "reader","author","publisher"
    field(:role, :string)
    field(:avatar_link, :string)
    belongs_to(:user, User, foreign_key: :user_id, type: :binary_id)
    has_many(:bookmark, Bookmark)

    timestamps(inserted_at: :created_on, updated_at: :modified_on)
  end

  @doc """
  This function uses a map of parameters to build a profile changeset
  """
  @spec changeset(Profile.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def changeset(%Profile{} = prof, attrs) do
    prof
    |> cast(attrs, [:username, :bio, :role, :avatar_link])
    |> validate_required([:username, :role])
    |> validate_inclusion(:role, ["reader", "author", "publisher"])
  end

  @doc """
  This function takes a user and a map of attributes that it then uses to
  build a profile associated with the user
  """
  @spec create_changeset(User.t(), map()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def create_changeset(%User{} = usr, attrs) do
    %Profile{}
    |> changeset(attrs)
    |> put_assoc(:user, usr)
  end
end

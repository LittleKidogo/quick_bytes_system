defmodule QbBackend.Posts.Comment do
@moduledoc """
This module defines the schema for the comments section of our app.
"""
  use Ecto.Schema
  import Ecto.Changeset

  alias QbBackend.{
    Posts.Comment,
    Accounts.Profile
  }

  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "comments" do
    field :body, :string
    belongs_to :profile, Profile, foreign_key: :manual_id, type: :binary_id

    timestamps(inserted_at: :created_on, updated_at: :modified_on)
  end

  @doc """
  this function adds comments changeset
  """
  @spec changeset(Comment.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def changeset(%Comment{} = comments, attrs) do
    comments
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end

  @doc """
  this function adds a comment to the manuals
  """
  @spec create_changeset(Profile.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def create_changeset(%Profile{} = post, params) do
    %Comment{}
    |> changeset(params)
    |> put_assoc(:profile, post)
  end
end

defmodule QbBackend.Posts.Comment do
@moduledoc """
This module defines the schema for the comments section of our app.
"""
  use Ecto.Schema
  import Ecto.Changeset

  alias QbBackend.{
    Posts.Comment,
    Accounts.Profile,
    Posts.Manual
  }

  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "comments" do
    field :body, :string
    belongs_to :profile, Profile, foreign_key: :profile_id, type: :binary_id
    belongs_to :manual, Manual, foreign_key: :manual_id, type: :binary_id

    timestamps(inserted_at: :added_on, updated_at: :edited_on)
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
  @spec create_changeset(Profile.t(), Manual.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def create_changeset(%Profile{} = profile, %Manual{} =  manual, params) do
    %Comment{}
    |> changeset(params)
    |> put_assoc(:profile, profile)
    |> put_assoc(:manual, manual)
  end
end

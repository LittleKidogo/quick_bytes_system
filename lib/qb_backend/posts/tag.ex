defmodule QbBackend.Posts.Tag do
  @moduledoc """
    This module hold the changeset and schema used by Tags
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias QbBackend.{
    Posts.Tag,
    Posts.Manual
  }

  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "tags" do
    field(:name, :string)

    many_to_many(
      :manuals,
      Manual,
      join_through: "manuals_tags",
      join_keys: [tag_id: :id, manual_id: :id],
      on_replace: :delete
    )

    timestamps(inserted_at: :added_on)
  end

  @doc """
  This function takes in a struct and a map containing parameters
  and proceeds to match the parameters to the schema above
  """
  @spec changeset(Tag.t(), map()) :: Ecto.Chnageset.t()
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @doc """
  This fuction builds a changeset for an association between a tag and a Manual
  """
  @spec add_to_manual(Tag.t(), Manual.t()) :: {:ok, Tag.t()} | {:error, Ecto.Changeset.t()}
  def add_to_manual(%Tag{manuals: manuals} = tag, %Manual{} = manual) do
    tag
    |> changeset(%{})
    |> put_assoc(:manuals, [manual] ++ manuals)
  end
end

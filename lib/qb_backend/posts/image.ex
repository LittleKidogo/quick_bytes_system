defmodule QbBackend.Posts.Image do
  @moduledoc """
  this module defines the schema for images
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias QbBackend.{
    Posts.Image,
    Accounts.Profile
  }

  @type t :: %__MODULE__{}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "images" do
    field :image_link, :string
    field :name, :string
    #belongs_to :manual, Manual, foreign_key: :manual_id, type: :binary_id
    belongs_to :profile, Profile, foreign_key: :manual_id, type: :binary_id

    timestamps(inserted_at: :created_on, updated_at: :modified_on)
  end

  @doc """
  function for the image changeset
  """
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:name, :image_link])
    |> validate_required([:name, :image_link])
  end

  @doc """
  function to add a new image associated to the manual
  """
  @spec create_changeset(Profile.t(), map()) :: {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  def create_changeset(%Profile{} = img, params) do
    %Image{}
    |> changeset(params)
    |> put_assoc(:manual, img)
  end
end

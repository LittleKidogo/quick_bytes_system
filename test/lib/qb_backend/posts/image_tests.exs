defmodule QbBackend.Posts.ImageTest do
  @moduledoc """
  this module comprises for tests for the images model
  """

  use QbBackend.DataCase

  alias QbBackend.{
    Posts.Image,
    Accounts.Profile,
    Posts.Manual
  }

  @valid_params %{image_link: "https://commons.wikimedia.org/wiki/File:20091007_Graffiti_Shanghai_7373.jpg", name: "2D"}
  @no_image_params %{name: "no image"}


  describe "image changesets" do
    test "valid image" do
      changeset = Image.changeset(%Image{},@valid_params)
      assert changeset.valid?
    end

    test "invalid/blank image" do
      changeset = Image.changeset(%Image{}, @no_image_params)
      refute changeset.valid?
    end

    test "update changesets" do
      image = insert(:image)
      changeset = Image.create_changeset(image,@valid_params)
      assert changeset.valid?
    end
  end

end

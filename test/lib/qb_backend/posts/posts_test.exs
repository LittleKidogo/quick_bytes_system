defmodule QbBackend.PostsTest do
  @moduledoc """
  This module holds unit tests for functions in the posts context
  """
  use QbBackend.DataCase

  alias QbBackend.{
    Posts,
    Posts.Manual,
    Posts.Comment,
    Posts.Image
  }

  @id "a7062358-021d-4273-827a-87c38cb213fe"
  @valid_manual %{title: "1,000 ways to die", body: " 1. Death by paperbag"}
  @valid_comment_params %{body: "This is a valid comment."}
  @valid_image_params %{
    name: "2D",
    image_link: "https://commons.wikimedia.org/wiki/File:20091007_Graffiti_Shanghai_7373.jpg"
  }
  @no_image_params %{name: "no image"}
  describe "Posts Context" do
    test "get_manual/1 gets a manual if one exists" do
      manual = insert(:manual)
      assert {:ok, %Manual{} = mnl} = Posts.get_manual(manual.id)
      assert manual.id == mnl.id
    end

    test "get_manual/1 returns an error is a manual does not exist" do
      assert Repo.aggregate(Manual, :count, :id) == 0
      assert {:error, "No Manual with id: #{@id} on the system"} == Posts.get_manual(@id)
    end

    test "create_manual/1 saves manual with valid data" do
      profile = insert(:profile)
      assert Repo.aggregate(Manual, :count, :id) == 0
      assert {:ok, %Manual{}} = Posts.create_manual(profile, @valid_manual)
      assert Repo.aggregate(Manual, :count, :id) == 1
    end

    test "create_manual/1 returns an error with invalid data" do
      profile = insert(:profile)
      assert Repo.aggregate(Manual, :count, :id) == 0
      assert {:error, _} = Posts.create_manual(profile, %{})
      assert Repo.aggregate(Manual, :count, :id) == 0
    end

    test "update_manual/2 updates a saved manual" do
      manual = insert(:manual)
      assert Repo.aggregate(Manual, :count, :id) == 1
      assert {:ok, %Manual{} = mnl} = Posts.update_manual(manual, @valid_manual)
      assert Repo.aggregate(Manual, :count, :id) == 1
      assert mnl.id == manual.id
      assert mnl.title != manual.title
    end

    @tag :update
    test "update_manual/2 returns an error with invalid data" do
      manual = insert(:manual)
      assert Repo.aggregate(Manual, :count, :id) == 1
      assert {:error, _} = Posts.update_manual(manual, %{title: 12})
      assert Repo.aggregate(Manual, :count, :id) == 1
      saved_manual = Repo.one(Manual)
      assert saved_manual.id == manual.id
      assert saved_manual.title == manual.title
    end

    test "add_comment/3 adds a comment from a user profile" do
      profile = insert(:profile)
      manual = insert(:manual)
      assert Repo.aggregate(Comment, :count, :id) == 0
      assert {:ok, %Comment{} = msg} = Posts.add_comment(profile, manual, @valid_comment_params)
      assert Repo.aggregate(Comment, :count, :id) == 1
      assert msg.body == @valid_comment_params[:body]
    end

    test "add_comment/3 gives an error on invalid data" do
      profile = insert(:profile)
      manual = insert(:manual)
      assert Repo.aggregate(Comment, :count, :id) == 0
      assert {:error, _changeset} = Posts.add_comment(profile, manual, %{})
      assert Repo.aggregate(Comment, :count, :id) == 0
    end

    test "edit_comment/2 updates the contents of the said comment" do
      msg = insert(:comment)
      assert Repo.aggregate(Comment, :count, :id) == 1
      {:ok, %Comment{} = newmsg} = Posts.edit_comment(msg, @valid_comment_params)
      assert Repo.aggregate(Comment, :count, :id) == 1
      assert newmsg.id == msg.id
      assert newmsg.body != msg.body
    end

    test "delete_comment/1 deletes a given comment" do
      msg = insert(:comment)
      assert Repo.aggregate(Comment, :count, :id) == 1
      {:ok, %Comment{} = del_msg} = Posts.delete_comment(msg)
      assert Repo.aggregate(Comment, :count, :id) == 0
      assert del_msg.id == msg.id
    end

    test "attach_image/3 adds an image to a manual" do
      profile = insert(:profile)
      manual = insert(:manual)
      assert Repo.aggregate(Image, :count, :id) == 0
      assert {:ok, %Image{} = img} = Posts.attach_image(profile, manual, @valid_image_params)
      assert Repo.aggregate(Image, :count, :id) == 1
      assert img.image_link == @valid_image_params[:image_link]
      assert img.name == @valid_image_params[:name]
    end

    test "attach_image/3 returns an error is no image is supplied" do
      profile = insert(:profile)
      manual = insert(:manual)
      assert Repo.aggregate(Image, :count, :id) == 0
      assert {:error, _changeset} = Posts.attach_image(profile, manual, @no_image_params)
      assert Repo.aggregate(Image, :count, :id) == 0
    end

    test "delete_image/1 actually delets a specified image" do
      img = insert(:image)
      assert Repo.aggregate(Image, :count, :id) == 1
      {:ok, %Image{} = del_img} = Posts.delete_image(img)
      assert Repo.aggregate(Image, :count, :id) == 0
      assert del_img.id == img.id
    end
  end
end

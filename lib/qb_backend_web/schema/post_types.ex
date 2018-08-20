defmodule QbBackendWeb.Schema.PostTypes do
  @moduledoc """
  This module contains GraphQL types used with
  the accounts context.
  """
  use Absinthe.Schema.Notation

  alias QbBackendWeb.{
    Resolvers.Posts
  }

  @desc "posts mutations"
  object :posts_mutations do
    @desc "create a manual"
    field :add_manual, :manual do
      arg(:input, non_null(:add_manual_input))
      meta(auth: ["publisher", "author"])
      resolve(&Posts.add_manual/3)
    end

    @desc "adds a comment"
    field :add_comment, :comment do
      arg(:input, non_null(:add_comment_input))
      meta(auth: ["publisher", "author", "reader"])
      resolve(&Posts.add_comment/3)
    end
  end

  @desc "manual type"
  object :manual do
    field(:title, :string)
    field(:body, :string)
    field(:id, :id)
  end

  @desc "input to create a manual on the system"
  input_object :add_manual_input do
    field(:title, non_null(:string))
    field(:body, non_null(:string))
  end

  @desc "comment type"
  object :comment do
    field(:body, :string)
    field(:id, :id)
    field(:profile_id, :id)
    field(:manual_id, :id)
  end

  @desc "input to add a comment on a manual"
  input_object :add_comment_input do
    field(:body, non_null(:string))
    field(:manual_id, non_null(:id))
  end
end

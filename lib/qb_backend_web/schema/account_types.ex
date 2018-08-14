defmodule QbBackendWeb.Schema.AccountTypes do
  @moduledoc """
  This module contains GraphQL types used with
  the accounts context.
  """
  use Absinthe.Schema.Notation

  @desc "an input object"
  input_object :session_input do
    field :username, non_null(:string)
    field :hash, non_null(:string)
  end

  @desc "A session object on the system"
  object :session do
    field(:profile, :profile)
    field(:token, :string)
  end

  @desc "Contains a user object in the system "
  object :user do
    field(:name, :string)
    field(:hash, :string)
  end

  @desc  "Contains a profile object of user on the system"
  object :profile do
    field(:username, :string)
    field(:role, :string)
    field(:bio, :string)
    field(:avatar_link, :string)
  end

end

